Rails.application.routes.draw do

  root to: 'pages#home'

  get 'dashboard' => 'pages#dashboard'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount Facebook::Messenger::Server, at: 'bot'

end
