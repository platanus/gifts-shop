require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(build(:product)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'product states with image' do
    let(:product) { create(:product, :with_image) }
    context 'when created' do
      it { expect(product).to have_state(:awaiting_approval) }
    end

    context 'when approving' do
      it { expect(product).to transition_from(:awaiting_approval).to(:approved).on_event(:approve) }
    end

    context 'when rejecting' do
      it { expect(product).to transition_from(:awaiting_approval).to(:rejected).on_event(:reject) }
    end
  end
end
