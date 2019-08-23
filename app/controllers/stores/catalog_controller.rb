class Stores::CatalogController < ApplicationController
  before_action :authenticate_store!

  def show
    @products = current_store.products
  end
end
