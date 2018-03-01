Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  devise_for :social_accounts, controllers: { omniauth_callbacks: 'callbacks' }
  root to: "home#index"
  resources :social_accounts do 
  	collection do
  		post 'add_account'
  	end
  end
  resources :users do
    resources :social_categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
