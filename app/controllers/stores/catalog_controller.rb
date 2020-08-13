class Stores::CatalogController < ApplicationController
  layout 'stores'
  before_action :authenticate_store!
  before_action :fill_product, only: [:edit, :update, :destroy]
  protect_from_forgery with: :exception

  def create
    add_product
    redirect_to stores_catalog_index_path
  end

  def edit; end

  def update
    if @product.update(product_update_params)
      @product.update_image(params[:image]) if params[:image]
      redirect_to stores_catalog_index_path
    else
      render :show
    end
  end

  def index
    @products = current_store.products.where(deleted: false)
  end

  def new; end

  def destroy
    @product.update(deleted: true)
    redirect_to stores_catalog_index_path
  end

  private

  def valid_url(url)
    unless url[%r[\Ahttp://]] || url[%r[\Ahttps://]]
      url = "http://#{url}"
    end
    url
  end

  def add_product
    if params[:image]
      @product = Product.create!(product_params)
      @product.update_image(params[:image])
    end
  end

  def fill_product
    @product = current_store.products.find(params[:id])
  end

  def product_update_params
    params.permit(:name, :link, :price)
  end

  def product_params
    params.permit(:name, :price).merge(store_id: current_store.id, link: valid_url(params[:link]))
  end
end
