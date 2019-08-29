class Stores::CatalogController < ApplicationController
  before_action :authenticate_store!
  protect_from_forgery with: :exception

  def create
    Rails.logger.debug params.inspect
  end

  def show
    @products = current_store.products
  end

  def new; end

  private

  def post_params
    params.require(:product).permit(:name, :link, :price, :image)
  end
end
