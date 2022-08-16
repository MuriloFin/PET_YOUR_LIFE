Rails.application.routes.draw do
  devise_for :users
  root to: 'pets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets do
    resources :adoptions, only: %i[new create show]
  end

  resources :about, only: :index
end
