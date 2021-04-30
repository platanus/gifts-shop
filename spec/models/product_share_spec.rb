require 'rails_helper'

RSpec.describe ProductShare, type: :model do
  subject(:product_share) { create(:product_share, platform: platform) }

  let(:platform) { 'email' }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:platform) }
    it { is_expected.to belong_to(:product) }

    context 'when shared by email' do
      it { is_expected.to validate_presence_of(:to_email) }
    end

    context 'when shared by whatsapp' do
      let(:platform) { 'whatsapp' }

      it { is_expected.not_to validate_presence_of(:to_email) }
    end
  end
end
