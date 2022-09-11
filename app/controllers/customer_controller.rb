# frozen_string_literal: true

# class CustomerController handles registration, login, logout and update
class CustomerController < ApplicationController
  def account
    # TODO: change this to load from cookies / sessions
    @customer = Customer.find(session[:user])
  end

  def register
    @customer = Customer.new
  end

  def save
    # TODO: fix params extraction error
    customer = Customer.new({ 'id': params[:id], 'email': params[:email], 'password': params[:password], 'firstname': params[:firstname], 'lastname': params[:lastname], 'phone': params[:phone], 'enabled': true })
    if customer.save
      create_session
      redirect_to action: :account
    else
      render action: 'register'
    end
  end

  # @note login renders the page, signin is the post action
  def login; end

  # @note signin is the post action of login (a page)
  def signin
    begin
      create_session
      act = :account
      flash.notice = 'Successfully logged in'
    rescue StandardError => e
      act = :login
      flash.alert = e.message
    end
    redirect_to action: act
  end

  def logout
    session[:user] = nil
    redirect_to action: :login
  end

  private

  def create_session
    if session[:user].nil?
      user = Customer.find_by(email: params[:email], password_digest: params[:password])
      return session[:user] = user.id unless user.nil?
      raise StandardError, 'No such user exists.'
    else
      raise StandardError, 'User already logged in.'
    end
  end

  def logged_in?
    session[:user].nil? == false
  end
end
