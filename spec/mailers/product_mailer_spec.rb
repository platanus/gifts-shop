require "rails_helper"

RSpec.describe ProductMailer, type: :mailer do
  describe '#share_email' do
    let(:params) do
      {
        to_email: "example@platan.us",
        product_name: "Chocolatera 2",
        product_price: 2000.0,
        product_link: "platan.us"
      }
    end

    let(:mail) { described_class.with(params).share_email.deliver_now }
    let(:from_email) { 'adolfo@platan.us' }

    before do
      stub_const('ProductMailer::DEFAULT_EMAIL_ADDRESS', from_email)
    end

    it 'renders the subject' do
      expect(mail.subject)
        .to eq("Compartiste el producto: #{params[:product_name]} | Buenas Ideas")
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([from_email])
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([params[:to_email]])
    end
  end
end
