require 'rails_helper'

RSpec.describe Deposit, type: :model do
  it "has a valid factory" do
    deposit = build(:deposit)
    expect(deposit).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to belong_to(:store) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end
end
