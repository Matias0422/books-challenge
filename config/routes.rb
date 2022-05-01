Rails.application.routes.draw do
  resources :books do
    member do
      patch :favorite
      patch :unfavorite
    end
  end
  resources :authors

  devise_for :users,
    controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }
end
