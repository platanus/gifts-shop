class Stores::CatalogController < ApplicationController
  before_action :authenticate_store!

  def create; end

  def show
    @products = current_store.products
  end

  def new; end

  private

  def post_params
    params.require(:product).permit(:name, :link, :price, :image)
  end
end
