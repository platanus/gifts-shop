require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "has a valid factory" do
    organization = build(:organization)
    expect(organization).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
