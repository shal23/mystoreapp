Mystoreapp::Application.routes.draw do
  resources :orders


  resources :line_items


  resources :carts


  get "store/index"

  resources :products do
    get :who_bought, on: :member
 end


  authenticated :user do
    root :to => 'home#index'
  end
  #root :to => "home#index"

  root to: 'store#index', as: 'store'
  devise_for :users
  resources :users
end