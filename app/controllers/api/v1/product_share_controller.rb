class Api::V1::ProductShareController < Api::V1::BaseController
  def create
    product_share_email
  end

  def product_share_email
    ProductMailer
      .with(
        to_email: share_params[:to_email],
        product_link: share_params[:product_link],
        product_name: share_params[:product_name],
        product_price: share_params[:product_price]
      )
      .share_email
      .deliver_later
  end

  private

  def share_params
    params.permit(:product_name, :product_price, :product_link, :to_email)
  end
end
