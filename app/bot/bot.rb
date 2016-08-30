require 'facebook/messenger'

Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.verify_token = ENV['VERIFY_TOKEN']
end

include Facebook::Messenger

# Facebook::Messenger::Thread.set(
#   setting_type: 'call_to_actions',
#   thread_state: 'new_thread',
#   call_to_actions: [{ payload: 'HIGUSTAVE' }]
# )

def menu(sender)
  Bot.deliver(
    recipient: sender,
    message: {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Un vin ? Un repas ?',
          buttons: [
            { type: 'postback', title: 'Suggère-moi un vin', payload: 'VIN' },
            { type: 'postback', title: 'Suggère-moi un repas', payload: 'REPAS' }
          ]
        }
      }
    }
  )
end

def intro_menu(sender)
  Bot.deliver(
    recipient: sender,
    message: {
      text: "En quoi puis-je t'aider ?"
    }
  )
end

def kind_of_meal(sender)
  @user.steps.create(name: "dish")

  Bot.deliver(
    recipient: sender,
    message: {
      text: "Que vas-tu manger ?"
    }
  )
end

def kind_of_wine(sender)
  @user.steps.create(name: "filtredcolor")
  Bot.deliver(
    recipient: sender,
    message: {
      text: "Tu veux déguster un rouge, blanc ou rosé ?"
    }
  )
end

def filter_wine(sender)
  Bot.deliver(
    recipient: sender,
    message: {
      text: "Veux-tu affiner la recherche par couleur ?"
    }
  )
end


def wine_id(color)
  if color == "rouge"
    1
  elsif color == "blanc"
    2
  elsif color == "rosé"
    3
  end
end


Bot.on :message do |message|
  puts "Received #{message.text} from #{message.sender}"


  @user = User.find_or_create_by_messenger_id(message.sender["id"])

  last_step = Step.where(user: @user).order({ created_at: :desc }).take

  if last_step
    case last_step.name
    when "dish"
      @dish = message.text
      last_step.update(response: message.text)
      call_vin(message.sender, last_step[:response])
    when "filtredcolor"
      last_step.update(response: message.text)
      call_vin(message.sender, @dish, wine_id(last_step[:response]))
    end
  end


  case message.text

  when /bonjour/i
    Bot.deliver(
        recipient: message.sender,
        message: {
          text: "Bonjour #{GetMessengerId.run(message.sender["id"])["first_name"]}! Je m'appelle Gustave. Je suis ton sommelier virtuel. Je peux te suggérer une bonne bouteille de vin ou un repas avec ton vin si tu l'as déjà. ;-)"
        }
      )
      menu(message.sender)

  when /menu/i
    menu(message.sender)

  when /🍷/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Bonjour très cher ! Je m'appelle Gustave. Je suis ton sommelier virtuel. Je peux te suggérer une bonne bouteille de vin ou un repas avec ton vin si tu l'as déjà. ;-)"
      }
    )
    menu(message.sender)

  when /hello/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Bonjour très cher ! Je m'appelle Gustave. Je suis ton sommelier virtuel. Je peux te suggérer une bonne bouteille de vin ou un repas avec ton vin si tu l'as déjà. ;-)"
      }
    )

  when /non/i
      Bot.deliver(
        recipient: message.sender,
        message: {
          text: "Très bien, je te laisse regarder les vins ! :)"
        }
      )

  # when /rouge/i
  #   call_vin_rouge(message.sender)

  when /vin/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "De quel vin parles-tu ? Ecris menu pour accéder aux fonctionnalités!"
      }
    )
  end
end

def wine_picture(vin_id)
  if Rails.env == "production"
    root_path = "https://bonjourgustave.herokuapp.com/assets/"
  else
    root_path = "https://fcb7060e.ngrok.io/assets/"
  end

  if vin_id == 2 || vin_id == 4 || vin_id == 5
    root_path + "c2.png"
  elsif vin_id == 1 || vin_id == 7
    root_path + "c1.png"
  elsif vin_id == 3 || vin_id == 6
    root_path + "c3.png"
  end
end


def call_vin(sender, dish, wine_type = 0)
  if Gustave.run({ dish: dish, wine_type: wine_type }).blank?

    Bot.deliver(
    recipient: sender,
    message: {
      text: "Aucun accord de vin trouvé"
    }
  )
  else
    Bot.deliver(
      recipient: sender,
      message: {
        text: "Voici ce que j'ai trouvé pour toi ! 🍷🍷🍷🍷🍷 "
      }
    )
    elements = []
    Gustave.run({ dish: dish, wine_type: wine_type }).each do |vin|
      elements << {
        title: vin["nom_vin"],
        image_url: wine_picture(vin["id_type_vin"].to_i),
        subtitle: "Un vin #{vin["type_vin"]} de la region #{vin["nom_region"]}",
         buttons:[
          {
            type: "web_url",
            url: "https://www.perdu.com",
            title: "Plus d'informations"
          },
          {
            type: "postback",
            title: "Sauvegarder ce vin",
            payload: "SAVE_WINE##{vin.to_json}##{dish}"
          }
        ]
      }
    end


    elements << {
      title: "Pas satisfait ?",
      image_url: "http://www.islamiclife.com/2016/02/29/7746.jpg",
      subtitle: "Essayer une nouvelle recherche ou filtre les vins!",
       buttons:[
        {
          type: "postback",
          title: "Nouvelle recherche",
          payload: "HIGUSTAVE"
        },
        {
          type: "postback",
          title: "Affiner la recherche",
          payload: "FILTER"
        }
      ]
    }


    Bot.deliver(
      recipient: sender,
      message: {
        attachment: {
          type: "template",
          payload: {
            template_type: 'generic',
            elements: elements
          }
        }
      }
    )

  end
end

Bot.on :postback do |postback|

  @user = User.find_or_create_by_messenger_id(postback.sender["id"])

  case postback.payload

  when 'HIGUSTAVE'
    @user.steps.create(name: "new")
    menu(postback.sender)
  when 'VIN'
    kind_of_meal(postback.sender)
  when 'REPAS'
    text = "J'ai bien reçu le callback du repas"
  when 'GOUTS'
    text = "J'ai bien reçu le callback de la cave"
  when 'FILTER'
    kind_of_wine(postback.sender)
  when /SAVE_WINE/i
    payload_data = postback.payload.match(/SAVE_WINE#(.*)#(.*)/)
    wine = JSON.parse(payload_data[1])
    dish = payload_data[2]
  end

end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
