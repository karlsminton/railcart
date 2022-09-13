# frozen_string_literal: true

# class CustomerController handles registration, login, logout and update
class CustomerController < ApplicationController
  def account
    @customer = Customer.find(session[:user])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Not logged in.'
    redirect_to action: :login
  end

  def register
    @customer = Customer.new
  end

  def save
    customer = Customer.new(customer_params)
    if customer.save
      session[:user] = customer.id
      redirect_to action: :account
    else
      flash.alert = customer.errors.full_messages
      render action: 'register'
    end
  end

  # @note login renders the page, signin is the post action
  def login; end

  # @note signin is the post action of login (a page)
  def signin
    begin
      authenticate
      act = :account
      flash.notice = 'You\'ve logged in successfully.'
    rescue StandardError => e
      act = :login
      flash.alert = e.message
    end
    redirect_to action: act
  end

  def logout
    session[:user] = nil
    flash[:notice] = 'You\'ve logged out successfully.'
    redirect_to action: :login
  end

  private

  def authenticate
    customer = Customer.find_by(email: params[:email])
    raise StandardError.new('No account with this email exists.') if customer.nil?

    raise StandardError.new('Incorrect password.') unless customer.authenticate(params[:password])

    session[:user] = customer.id
  end

  def customer_params
    params.require(:customer).permit(:id, :email, :password, :firstname, :lastname, :phone)
  end
end
