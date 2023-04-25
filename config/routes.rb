Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
    }

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
     delete '/users/:id', to: 'devise/registrations#destroy' 
    get '/admin', to: 'admin/sessions#new'
  end
  # devise_for :users
  resources :roles, path: '/admin/roles'
  resources :products, path: '/admin/products'
  resources :categories, path: '/admin/categories'

  # get '/admin/categories', to: 'categories#index'
  
 
  get '/admin/customers', to: 'pages#customers', as: 'customers'
  get '/admin', to: 'pages#index'

  #  For Customers 
  
  get '/categories/:id' => 'pages#categories_index'


  get '/product/:id' => 'pages#product_detail', as: 'product_detail'
  get '/product' => 'pages#product_index', as: 'product_index'


 
 
 
 
  

  # always set the default root URL, regardless of the condition
  root 'pages#index'

  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy" 
  
  post '/line_items', to: 'line_items#create'
  get 'line_items/:id' => "line_items#show", as: "line_item"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  delete 'line_items/:id' => "line_items#destroy"
  get '/local_cart', to: 'carts#local_cart'

  # resources :orders
  get '/orders/new', to: 'orders#new'
   post '/orders', to: 'orders#create'



end
