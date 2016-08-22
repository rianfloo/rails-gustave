require 'facebook/messenger'

Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.verify_token = ENV['VERIFY_TOKEN']
end

include Facebook::Messenger

Facebook::Messenger::Thread.set(
  setting_type: 'greeting',
  greeting: {
    text: 'Welcome to Gustave'
  }
)

Facebook::Messenger::Thread.set(
  setting_type: 'call_to_actions',
  thread_state: 'new_thread',
  call_to_actions: [
    {
      payload: 'WELCOME'
    }
  ]
)

Bot.on :message do |message|
  puts "Received #{message.text} from #{message.sender}"

  case message.text
  when /bonjour/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Bonjour très cher ! Je m'appelle Gustave. Je suis ton sommelier virtuel."
      }
    )
  when /menu/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "En quoi puis-je vous aider aujourd'hui ?"
      }
    )

    Bot.deliver(
      recipient: message.sender,
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

  when /cave/i
    Bot.deliver(
      recipient: message.sender,
      message: {
        attachment: {
        type: 'image'

        }
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

Bot.on :postback do |postback|
  case postback.payload
  when 'VIN'
    text = "J'ai bien reçu le callback du vin"
  when 'REPAS'
    text = "J'ai bien reçu le callback du repas"
  when 'GOUTS'
    text = "J'ai bien reçu le callback de la cave"
  when 'WELCOME'
    text = "Bonjour très cher ! Je m'appelle Gustave. Je suis ton sommelier virtuel. Tu peux peux écrire menu pour me découvrir!"
  end

  Bot.deliver(
    recipient: postback.sender,
    message: {
      text: text
    }
  )
end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
