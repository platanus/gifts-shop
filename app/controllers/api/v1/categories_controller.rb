class Api::V1::CategoriesController < Api::V1::BaseController
  before_action :set_random_seed, only: :index
  after_action :unset_cold_start, only: :index

  def index
    category = Category.not_empty.randomized(session[:seed], session[:cold]).page(page).per(1)
    get_new_seed unless category.next_page
    respond_with category, meta: {
      next_page: category.next_page
    }
  end

  def show
    category = Category.find(permitted_params[:id])
    respond_with category, root: false
  end

  private

  def permitted_params
    params.permit(:id)
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

  def page
    return "1" if session[:cold]

    query_params[:page]
  end

  def unset_cold_start
    session[:cold] = nil
  end
end
