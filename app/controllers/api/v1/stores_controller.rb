class Api::V1::StoresController < Api::V1::BaseController
  def show
    store = Store.find_by(balance_params)
    respond_with store
  end

  private

  def balance_params
    params.permit(:id)
  end
end
