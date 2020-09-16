class Api::V1::CategoriesController < Api::V1::BaseController
  before_action :set_random_seed, only: :index

  def index
    category = Category.randomized(session[:seed]).page(query_params[:page]).per(1)
    get_new_seed unless category.next_page
    respond_with category, meta: {
      next_page: category.next_page
    }
  end

  def query_params
    params.permit(:page)
  end

  def set_random_seed
    get_new_seed unless session[:seed]
  end

  def get_new_seed
    srand
    session[:seed] = rand(-1.0...1.0)
  end
end
