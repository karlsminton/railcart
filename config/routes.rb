# frozen_string_literal: true

Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  # Front End Routes
  # Homepage
  root 'home#index'

  # Categories
  get '/categories', to: 'category#index'
  get '/category/new', to: 'category#new'
  get '/category/edit/:id', to: 'category#edit', as: 'category_edit'
  get '/category/:url_key', to: 'category#view', as: 'category_view'
  post '/category/save', to: 'category#save'

  # Products
  get '/products', to: 'product#list'
  get '/product/new', to: 'product#new'
  get '/product/edit/:id', to: 'product#edit', as: 'product_edit'
  get '/product/delete/:id', to: 'product#delete', as: 'product_delete'
  get '/product/:url_key', to: 'product#view', as: 'product'
  post '/product/save', to: 'product#create'
  patch '/product/save', to: 'product#update'
  put '/product/save', to: 'product#update'

  # Customer
  get '/customer/account', to: 'customer#account'
  get '/customer/register', to: 'customer#register'
  get '/customer/login', to: 'customer#login'
  get '/customer/logout', to: 'customer#logout'
  post '/customer/save', to: 'customer#save'
  post '/customer/signin', to: 'customer#signin'
  get '/customer', to: 'customer#index'
  get '/customer/edit/:id', to: 'customer#edit', as: 'customer_edit'
  get '/customer/new', to: 'customer#new', as: 'customer_new'

  # Admin Routes
  # Generic Admin Controller (might not need all of these)
  get '/admin', to: 'admin#index'
  get '/admin/login', to: 'admin#login'
  get '/admin/create', to: 'admin#create'
  post '/admin/save', to: 'admin#save'

  # Cart Routes
  post '/cart/add', to: 'cart#add'
  get '/cart/clear', to: 'cart#clear'

  # Checkout Routes
  get '/checkout', to: 'checkout#index', as: 'checkout_index'
  get '/checkout/success', to: 'checkout#success', as: 'checkout_success'
  get '/checkout/success', to: 'checkout#failure', as: 'checkout_failure'
  post '/checkout/place', to: 'checkout#place', as: 'checkout_place'

  # Order Routes
  get '/order', to: 'order#index'

  # Image Routes
  get '/image', to: 'image#index'
end
