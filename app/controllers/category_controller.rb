class CategoryController < ApplicationController
  def index; end

  def view
    pass unless params.include?(:url_key)
    key = params[:url_key]
    category = Category.find_by(url: key)
    return redirect_to({ action: :view, controller: :product, url_key: key })

    @category = category
  end
end
