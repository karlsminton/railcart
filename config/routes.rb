# frozen_string_literal: true

Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  # Front End Routes
  # Homepage
  root 'home#index'

  # Categories
  get '/categories', to: 'category#index'
  get '/category/new', to: 'category#new'
  get '/category/:url_key', to: 'category#view', as: 'category'
  post '/category/save', to: 'category#save'

  # Products
  get '/product/:url_key', to: 'product#view', as: 'product'

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

  # Manage Products
  get '/admin/product', to: 'product#list'
  get '/admin/product/new', to: 'product#new'
  get '/admin/product/edit/:id', to: 'product#edit', as: 'admin_product_edit'
  post '/admin/product/create', to: 'product#create'

  # Cart Routes
  post '/cart/add', to: 'cart#add'
end
