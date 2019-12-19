require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(build(:product)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:link) }
  end
end
