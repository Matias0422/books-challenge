Rails.application.routes.draw do
  resources :books do
    member do
      patch :favorite
    end
  end
  resources :authors

  devise_for :users,
    controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }
end
