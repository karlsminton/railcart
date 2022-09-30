# frozen_string_literal: true

# class CartController handles adding, removing and clearing products in cart / basket
class CartController < ApplicationController
  # TODO: fix below to conform to rubocop - way too big
  def add
    prod = Product.find(params[:id])
    requested_qty = params[:qty]
    if cookies[:cart].nil?
      cookies[:cart] = JSON.generate({ prod.id => requested_qty.to_i })
      flash[:notice] = "#{params[:qty]} #{prod.name} in basket"
    else
      cart = JSON.parse cookies[:cart]
      cart[prod.id.to_s] = requested_qty.to_i + cart[prod.id.to_s].to_i
      cookies[:cart] = JSON.generate(cart)
      flash[:notice] = "#{cart[prod.id.to_s]} #{prod.name} in basket"
    end
    redirect_back fallback_location: root_path
  end

  # TODO: add method to update existing qty of products
  def update; end

  def clear
    cookies.delete :cart
    flash[:notice] = 'Cart cleared.'
    redirect_back fallback_location: root_path
  end
end
