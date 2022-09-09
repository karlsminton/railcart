# frozen_string_literal: true

# class CartController handles adding, removing and clearing products in cart / basket
class CartController < ApplicationController
  def add
    product = Product.find(params[:id])
    add_to_cart unless params[:qty] > product.stock_qty
    # Add to cart here
  end

  def update; end
  def clear; end

  private

  def add_to_cart; end
end
