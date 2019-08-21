class Stores::CatalogController < ApplicationController
  before_action :authenticate_store!

  def show; end
end
