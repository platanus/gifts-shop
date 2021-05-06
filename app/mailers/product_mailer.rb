class ProductMailer < ApplicationMailer
  DEFAULT_EMAIL_ADDRESS = ENV.fetch('DEFAULT_EMAIL_ADDRESS')
  APPLICATION_HOST = ENV.fetch('APPLICATION_HOST')

  before_action do
    @to_email = params[:to_email]
    @product_name = params[:product_name]
    @product_price = params[:product_price]
    @product_link = params[:product_link]
  end

  def share_email
    mail(
      subject: share_email_subject,
      from: DEFAULT_EMAIL_ADDRESS,
      to: @to_email
    )
  end

  private

  def share_email_subject
    "Compartiste el producto: #{@product_name} | Buenas Ideas"
  end
end
