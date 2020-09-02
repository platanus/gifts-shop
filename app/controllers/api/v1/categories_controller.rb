class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    category = Category.page(query_params[:page]).per(1)
    respond_with category, meta: {
      next_page: category.next_page
    }
  end

  def query_params
    params.permit(:page)
  end
end
