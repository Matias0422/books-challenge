Rails.application.routes.draw do
  resources :books
  resources :authors

  devise_for :users,
    controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }

end
