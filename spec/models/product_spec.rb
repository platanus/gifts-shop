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
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price_interval) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category).optional }
  end

  describe 'product states with image' do
    let(:product) { build(:product, :with_image) }

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

  describe 'product price interval' do
    let(:price) { 12000 }
    let(:product) { build(:product, price: price) }

    context 'when saving product' do
      it { expect { product.save! }.to change { product.price_interval }.from(0).to(1) }
    end

    context 'when updating price' do
      let(:product) { create(:product, price: price) }
      let(:new_price) { 18000 }

      it { expect(product.price_interval).to eq(1) }

      it { expect { product.update!(price: new_price) }
        .to change { product.price_interval }.from(1).to(2)
      }
    end
  end
end
