Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Front End Routes
  root 'home#index'
  get '/categories', to: 'category#index'
  get '/category/:url_key', to: 'category#view', as: 'category'
  get '/product/:url_key', to: 'product#view', as: 'product'

  # Admin Routes
  # Generic Admin Controller (might not need all of these)
  get '/admin', to: 'admin#index'
  get '/admin/login', to: 'admin#login'
  get '/admin/create', to: 'admin#create'
  post '/admin/save', to: 'admin#save'
  # Manage Products
  get '/admin/product', to: 'product#list'
  get '/admin/product/new', to: 'product#new'
  get '/admin/product/edit/:id', to: 'product#edit', as: 'admin_product_edit'
  post '/admin/product/create', to: 'product#create'
  # Cart Routes
  post '/cart/add', to: 'cart#add'
end
