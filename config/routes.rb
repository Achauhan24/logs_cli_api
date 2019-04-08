Rails.application.routes.draw do
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, defaults: { format: :json }

  resources :users
  # root to: 'log#show'

  get 'logs' => 'logs#get_log_changes'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
