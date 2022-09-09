class ProductController < ApplicationController
  def view
    # TODO: check if product is enabled before serving
    product = Product.find_by(url: params[:url_key])
    if product
      @product = product
    else
      redirect_back fallback_location: root_path
    end
  end

  def list
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    # TODO: fix this mess - ugly solution to weird param issue - when trying to filter I'm getting invalid params
    data = { "sku": params[:sku], "name": params[:name], "url": params[:url], "price": params[:price], "enabled": params[:enabled], "description": params[:description], "stock_qty": params[:stock_qty] }
    product = Product.create(data)
    if product.save
      redirect_to({ controller: :product, action: :list })
    else
      render action: 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end
end
