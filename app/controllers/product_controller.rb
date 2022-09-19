# frozen_string_literal: true

# class ProductController handles CRUD for products
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
    product = Product.new(product_params)
    product.categories = Category.find category_params
    if product.save
      redirect_to controller: :product, action: :list
    else
      flash[:alert] = product.errors.full_message
      render action: 'new'
    end
  end

  def update
    data = product_params
    product = Product.find(data[:id])
    product.categories = Category.find category_params
    if product.update(data)
      flash[:notice] = "Product #{product.name} saved successfully."
      redirect_to action: :list
    else
      flash[:alert] = product.errors.full_message
      render action: 'list'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(
      :id, :sku, :name, :url, :price, :enabled, :description, :stock_qty, :image, :categories
    )
  end

  def category_params
    categories = params[:product][:categories][:category]
    categories.reject(&:empty?)
  end
end
