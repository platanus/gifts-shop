class Api::V1::ProductShareController < Api::V1::BaseController
  def create
    product_share = save_share
    send_product_share_email if create_params[:platform] == "email"

    respond_with product_share
  end

  def send_product_share_email
    ProductMailer
      .with(
        to_email: share_params[:to_email],
        product_link: share_params[:product_link],
        product_name: product.name,
        product_price: product.price
      )
      .share_email
      .deliver_later
  end

  private

  def save_share
    ProductShare.create!(
      product_id: create_params[:product_id],
      platform: create_params[:platform],
      to_email: share_params[:to_email]
    )
  end

  def share_params
    params.permit(:product_link, :to_email)
  end

  def create_params
    params.require(:product_share).permit(:product_id, :platform)
  end

  def product
    @product ||= Product.find_by(id: create_params[:product_id])
  end
end
