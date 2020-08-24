class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    respond_with Category.first(10)
  end
end