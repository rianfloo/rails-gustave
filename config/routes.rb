Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  mount Messenger::Engine, at: "/messenger"
end
