Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets, shallow: true do
    resources :adoptions, only: %i[new create show]
    resources :chatrooms, only: %i[show create] do
      resources :messages, only: :create
    end
  end

  resources :likes, only: [:index, :create, :new, :destroy]

  get "pets", to: 'pets#index'
  get "about", to: "pages#about"
  get "terms", to: "pages#terms"
  get "touch", to: "pages#touch"
  get "donate", to: "pages#donate"
end
