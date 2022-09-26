# frozen_string_literal: true

require 'json'

# class CheckoutController handles order placement and related views
class CheckoutController < ApplicationController
  def index
    @customer = session[:user] unless session[:user].nil?
  end

  def place
    # Generate order model with order data
    user = customer
    cart = cart_data
    @order = Order.new({ customer: user, products: cart[:products], cost: cart[:total] })
    # Place order with payment gateway
    management = PaypalManagement.new
    management.place(@order)

    # if successful;
    # deduct stock against products ordered
    if @order.paypal_status == 'CREATED'
      products = cart[:products]
      products.each do |item|
        prod = Product.find(item[:product].id)
        prod.stock_qty = prod.stock_qty - item[:qty]
        prod.save
      end

      # clear cart
      cookies.delete :cart

      # redirect to success page
      @order.save
      action = :success
      cookies[:success] = @order.id
    else
      action = :failure
    end

    # if unsuccessful; redirect to checkout or failure page, print reason for failure
    redirect_to action:
  end

  def success
    @order_id = cookies[:success]
    cookies.delete :success
  end

  def failure; end

  private

  def order_params
    params.permit(:email, :firstname, :lastname, :phone, :house, :street, :town, :postcode, :country)
  end

  def customer
    if session[:user]
      Customer.find(session[:user])
    else
      Customer.find_by_email(params[:email])
    end
  end

  def cart_data
    data = {}
    data[:total] = 0.0
    cart = JSON.parse(cookies[:cart])
    cart.each do |product_id, qty|
      prod = Product.find(product_id)
      if data[:products].nil?
        data[:products] = []
      end
      data[:products] << { product: prod, qty: }
      data[:total] += (prod.price * qty)
    end
    data
  end
end
