class Api::V1::ProductActionsController < Api::V1::BaseController
  def create
    mark_displayed
  end

  private

  def mark_displayed
    receiver_id = set_receiver_id
    ActiveRecord::Base.transaction do
      permitted_params[:products].each do |_key, value|
        ProductAction.create!(
          receiver_id: receiver_id,
          product_id: value[:id],
          action_type: 0
        )
      end
    end
  end

  def permitted_params
    params.permit(products: {})
  end

  def set_receiver_id
    cookies[:receiver_id]
  end
end
