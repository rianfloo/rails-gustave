require 'facebook/messenger'

Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.verify_token = ENV['VERIFY_TOKEN']
end

include Facebook::Messenger

Facebook::Messenger::Thread.set(
  setting_type: 'call_to_actions',
  thread_state: 'new_thread',
  call_to_actions: [{ payload: 'WELCOME' }]
)

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
  Bot.deliver(
    recipient: sender,
    message: {
      text: "Que vas-tu manger ?"
    }
  )
end

def kind_of_wine(sender)
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

Bot.on :message do |message|
  puts "Received #{message.text} from #{message.sender}"


  @mesenger_id = message.sender["id"]
  User.find_or_create_by_messenger_id(@mesenger_id)

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
    intro_menu(message.sender)
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


  when /poulet/i
    call_vin(message.sender)

  when /rouge/i
    call_vin_rouge(message.sender)

  when /vin/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "De quel vin parles-tu ? Ecris menu pour accéder aux fonctionnalités!"
      }
    )

  else
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Je n'ai pas très bien compris mon cher..."
      }
    )

    Bot.deliver(
      recipient: message.sender,
      message: {
        text: 'Ecris : menu pour accéder au menu :)'
      }
    )
  end
end

def wine_picture(vin_id)
  if Rails.env == "production"
    root_path = "https://bonjourgustave.herokuapp.com/assets/"
  else
    root_path = "https://34a8e09d.ngrok.io/assets/"
  end

  if vin_id == 2 || vin_id == 4 || vin_id == 5
    root_path + "c2.png"
  elsif vin_id == 1 || vin_id == 7
    root_path + "c1.png"
  elsif vin_id == 3 || vin_id == 6
    root_path + "c3.png"
  end
end


def call_vin(sender)
  Bot.deliver(
    recipient: sender,
    message: {
      text: "Voici ce que j'ai trouvé pour toi ! 🍷🍷🍷🍷🍷 "
    }
  )
  elements = []
  Gustave.run({ dish: "Poulet" }).each do |vin|
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
          payload: "USER_DEFINED_PAYLOAD"
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
        payload: "WELCOME"
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

# def call_vin_rouge(sender)
#   Bot.deliver(
#       recipient: sender,
#       message: {
#         text: "Et voici du rouge! 🍷🍷🍷🍷🍷🍷 "
#       }
#     )
#   Bot.deliver(
#     recipient: sender,
#     message: {
#       attachment: {
#         type: "template",
#         payload: {
#           template_type: 'generic',
#           elements: [
#             {
#               title: "Vin du jour coucou",
#               image_url: "http://lesgourmands2-0.com/wp-content/uploads/2014/06/game-of-thrones-vin-2.jpg",
#               subtitle: "Un petit vin de producteur",
#                buttons:[
#                 {
#                   type: "web_url",
#                   url: "https://www.perdu.com",
#                   title: "Plus d'informations"
#                 },
#                 {
#                   type: "postback",
#                   title: "Sauvegarder ce vin",
#                   payload: "USER_DEFINED_PAYLOAD"
#                 }
#               ]
#             },
#             {
#               title: "Vin du jour coucou",
#               image_url: "http://lesgourmands2-0.com/wp-content/uploads/2014/06/game-of-thrones-vin-2.jpg",
#               subtitle: "Un petit vin de producteur",
#                buttons:[
#                 {
#                   type: "web_url",
#                   url: "https://www.perdu.com",
#                   title: "Plus d'informations"
#                 },
#                 {
#                   type: "postback",
#                   title: "Sauvegarder ce vin",
#                   payload: "USER_DEFINED_PAYLOAD"
#                 }
#               ]
#             },
#             {
#               title: "Vin du jour coucou",
#               image_url: "http://lesgourmands2-0.com/wp-content/uploads/2014/06/game-of-thrones-vin-2.jpg",
#               subtitle: "Un petit vin de producteur",
#                buttons:[
#                 {
#                   type: "web_url",
#                   url: "https://www.perdu.com",
#                   title: "Plus d'informations"
#                 },
#                 {
#                   type: "postback",
#                   title: "Sauvegarder ce vin",
#                   payload: "USER_DEFINED_PAYLOAD"
#                 }
#               ]
#             },
#             {
#               title: "Vin du jour coucou",
#               image_url: "http://lesgourmands2-0.com/wp-content/uploads/2014/06/game-of-thrones-vin-2.jpg",
#               subtitle: "Un petit vin de producteur",
#                buttons:[
#                 {
#                   type: "web_url",
#                   url: "https://www.perdu.com",
#                   title: "Plus d'informations"
#                 },
#                 {
#                   type: "postback",
#                   title: "Sauvegarder ce vin",
#                   payload: "USER_DEFINED_PAYLOAD"
#                 }
#               ]
#             },
#             {
#               title: "Vin du jour coucou",
#               image_url: "http://lesgourmands2-0.com/wp-content/uploads/2014/06/game-of-thrones-vin-2.jpg",
#               subtitle: "Un petit vin de producteur",
#                buttons:[
#                 {
#                   type: "web_url",
#                   url: "https://www.perdu.com",
#                   title: "Plus d'informations"
#                 },
#                 {
#                   type: "postback",
#                   title: "Sauvegarder ce vin",
#                   payload: "USER_DEFINED_PAYLOAD"
#                 }
#               ]
#             }
#           ]
#         }
#       }
#     }
#   )
# end

Bot.on :postback do |postback|

  case postback.payload

  when 'WELCOME'
    text = "Bonjour très cher ! Je m'appelle Gustave. Je suis ton sommelier virtuel. Tu peux peux écrire menu pour me découvrir!"
  when 'VIN'
    kind_of_meal(postback.sender)
  when 'REPAS'
    text = "J'ai bien reçu le callback du repas"
  when 'GOUTS'
    text = "J'ai bien reçu le callback de la cave"
  when 'FILTER'
    kind_of_wine(postback.sender)
  end

end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
