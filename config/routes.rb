# frozen_string_literal: true

Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  # Front End Routes
  # Homepage
  root 'home#index'

  # Categories
  get '/categories', to: 'category#index'
  get '/category/new', to: 'category#new'
  get '/category/:url_key', to: 'category#view', as: 'category_view'
  post '/category/save', to: 'category#save'

  # Products
  get '/products', to: 'product#list'
  get '/product/new', to: 'product#new'
  get '/product/edit/:id', to: 'product#edit', as: 'product_edit'
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
  get '/checkout', to: 'checkout#index'
  post '/checkout/place', to: 'checkout#place'
end
