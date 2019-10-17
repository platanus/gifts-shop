class Stores::CatalogController < ApplicationController
  layout 'stores'
  before_action :authenticate_store!
  before_action :fill_product, only: [:edit, :update]
  protect_from_forgery with: :exception

  def create
    add_product
    redirect_to stores_catalog_index_path
  end

  def edit; end

  def update
    if @product.update(product_update_params)
      @product.image.attach(params[:image]) if params[:image]
      redirect_to stores_catalog_index_path
    else
      render :show
    end
  end

  def index
    @products = current_store.products
  end

  def new; end

  private

  def add_product
    @product = Product.create!(product_params)
    @product.image.attach(params[:image])
  end

  def fill_product
    @product = current_store.products.find(params[:id])
  end

  def product_update_params
    params.permit(:name, :link, :price)
  end

  def product_params
    params.permit(:name, :link, :price).merge(store_id: current_store.id)
  end
end
