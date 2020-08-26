class Stores::CatalogController < ApplicationController
  layout 'stores'
  #before_action :authenticate_store!
  before_action :fill_product, only: [:edit, :update, :destroy]
  protect_from_forgery with: :exception

  def create
    add_product
    redirect_to new_stores_catalog_path
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
      @product = Product.create!(product_params)
    if params[:image]
      @product.update_image(params[:image])
    end
  end

  def fill_product
    @product = current_store.products.find(params[:id])
  end

  def product_update_params
    params.permit(:name, :link, :price, :email)
  end

  def product_params
    default_store = Store.find_by(email: ENV.fetch('DEFAULT_STORE_EMAIL'))
    params.permit(:name, :price, :email).merge(store_id: default_store.id, link: valid_url(params[:link]))
  end
end
