class Stores::CatalogController < ApplicationController
  before_action :authenticate_store!
  protect_from_forgery with: :exception

  def create
    add_product
    redirect_to stores_catalog_path
  end

  def show
    @balance = current_store.balance
    @products = current_store.products
  end

  def new; end

  private

  def add_product
    @product = Product.create!(product_params)
    @product.image.attach(params[:image])
  end

  def product_params
    params.permit(:name, :link, :price).merge(store_id: current_store.id)
  end
end
