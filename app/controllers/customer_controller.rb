# frozen_string_literal: true

# class CustomerController handles registration, login, logout and update
class CustomerController < ApplicationController
  def account
    # TODO: change this to load from cookies / sessions
    @customer = Customer.all.last
  end

  def register
    @customer = Customer.new
  end

  def save
    # TODO: fix params extraction error
    data = { 'email': params[:email], 'password': params[:password], 'firstname': params[:firstname], 'lastname': params[:lastname], 'phone': params[:phone], 'enabled': true }
    customer = Customer.new(data)
    if customer.save
      # TODO: should create session here
      redirect_to action: :account
    else
      render action: 'register'
    end
  end

  def login; end
  def logout; end
end
