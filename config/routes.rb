Rails.application.routes.draw do

# admin側のdevise
  namespace :admin do
    devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations',


    passwords: 'admin/admins/passwords'

  }
end

# customer側のdevise
  scope module: 'customer' do
  devise_for :customers, controllers: {
    sessions: 'customer/customers/sessions',
    registrations: 'customer/customers/registrations',

    

    passwords: 'customer/cuscustomers/passwords'

  }
end


# admin側のルーティング(URLの頭にadminがつく)
namespace :admin do
  root :to => 'home#top'
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :ordered_products, only: [:update]
  resources :orders, only: [:index, :show, :update]
  resources :products, only: [:index, :show, :new, :create, :edit, :update]
end

# customer側のルーティング
scope module: 'customer' do
  root :to => 'home#top'
  get 'home/about' => 'home#about', as: 'about'
  resources :cart_items, only: [:index, :create, :update, :destroy]
  delete 'cart_items' => 'cart_items#delete_all', as: 'delete_all_cart_items'
  resource :customer, only: [:show, :edit, :update]
  get 'customer/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
  patch 'customer/change' => 'customers#change',
  as: 'change_customer'
  resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  resources :orders, only: [:index, :show, :new, :create]
  post 'orders/confirm' => 'orders#confirm', as: 'confirm_order'
  post 'orders/complete' => 'orders#complete', as: 'order_completed'
  resources :products, only: [:index, :show]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
