# frozen_string_literal: true

# class ProductController handles CRUD for products
class ProductController < ApplicationController
  def view
    # TODO: check if product is enabled before serving
    product = Product.where({ url: params[:url_key], enabled: true }).first
    if product
      @product = product
    else
      flash[:alert] = 'Product is not available.'
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
    # product.images = product_images
    product.images = product_images
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
      :id, :sku, :name, :url, :price, :enabled, :description, :stock_qty, :images, :image, :categories
    )
  end

  def category_params
    categories = params[:product][:categories][:category]
    categories.reject(&:empty?)
  end

  def product_images
    images = []
    data = params[:product][:images][:image]
    name = data.original_filename
    path = File.join('app', 'assets', 'images', 'upload', name)
    File.open(path, 'wb') { |f| f.write(data.read) }
    image = Image.new({ name:, path:, alt_tag: name})
    image.save
    images.append(image)
  end
end
