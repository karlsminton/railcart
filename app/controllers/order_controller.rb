class OrderController < ApplicationController
  layout 'admin'

  def index
    @orders = Order.all
  end
end