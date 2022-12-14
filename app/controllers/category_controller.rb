class CategoryController < ApplicationController
  layout 'admin', only: [:index, :new, :edit]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def save
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category #{@category.name} saved correctly"
    else
      flash[:alert] = @category.errors.full_messages
    end
    redirect_to action: :new
  end

  def view
    @category = Category.find_by(url: params[:url_key])
  end

  private

  def category_params
    params.require(:category).permit(:id, :name, :url, :description)
  end
end
