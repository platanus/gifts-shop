require 'rails_helper'

RSpec.describe Api::V1::ProductShareController, type: :controller do
  describe 'POST #create' do
    let(:product) { create(:product) }
    let(:product_share_params) do
      {
        product_share: {
          platform: "email",
          product_id: product.id
        },
        to_email: "example@platan.us",
        product_link: "platan.us"
      }
    end
    let(:mailer_params) do
      {
        to_email: "example@platan.us",
        product_link: "platan.us",
        product_name: product.name,
        product_price: product.price
      }
    end
    let(:product_mailer) do
      instance_double('ProductMailer', share_email: message_delivery)
    end
    let(:message_delivery) do
      instance_double('ActionMailer::MessageDelivery', deliver_later: nil)
    end

    before do
      allow(ProductMailer).to receive(:with).and_return(product_mailer)
    end

    context 'with valid params' do
      it 'returns http success' do
        post :create, format: :json, params: product_share_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'when email was requested' do
      it 'shares product by email' do
        post :create, format: :json, params: product_share_params
        expect(ProductMailer).to have_received(:with).with(mailer_params)
        expect(product_mailer).to have_received(:share_email)
        expect(message_delivery).to have_received(:deliver_later)
      end
    end
  end
end
