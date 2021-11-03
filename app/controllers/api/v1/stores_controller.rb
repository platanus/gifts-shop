class Api::V1::StoresController < Api::V1::BaseController
  before_action :set_random_seed

  def index
    store = Store.randomized(session[:seed]).page(index_params[:page]).per(1)
    get_new_seed unless store.next_page
    respond_with store, meta: {
      next_page: store.next_page
    }
  end

  def add_social_network_click
    store = Store.find(params[:id])
    store.add_social_network_click(params[:social_media])
  end

  private

  def index_params
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
