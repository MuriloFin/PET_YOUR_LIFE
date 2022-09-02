Rails.application.routes.draw do
  devise_for :users
  root to: 'pets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets, shallow: true do
    resources :adoptions, only: %i[new create show]
    resources :chatrooms, only: %i[show create] do
      resources :messages, only: :create
    end
  end

  resources :likes, only: [:index, :create, :new, :destroy]

  get "about", to: "pages#about"
  get "terms", to: "pages#terms", as: 'terms'
  get "touch", to: "pages#touch", as: 'touch'
  get "donate", to: "pages#donate", as: 'donate'
end
