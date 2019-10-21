class Api::V1::CatalogsController < Api::V1::BaseController
  def update
    Product.find_by(id: permitted_params[:id].to_i).toggle(permitted_params[:type]).save
  end

  private

  def permitted_params
    params.permit(:id, :type)
  end
end
