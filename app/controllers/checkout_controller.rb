# frozen_string_literal: true

# class CheckoutController handles order placement and related views
class CheckoutController < ApplicationController
  def index
    @customer = session[:user] unless session[:user].nil?
  end

  def place
    # Generate order model with order data
    # Place order with payment gateway

    # if successful;
    # deduct stock against products ordered
    # redirect to success page
    # clear cart

    # if unsuccessful;
    # redirect to checkout or failure page
    # print reason for failure
  end

  def success; end
  def failure; end

  private

  def order_params
    params.permit(:email, :firstname, :lastname, :phone, :house, :street, :town, :postcode, :country)
  end
end
