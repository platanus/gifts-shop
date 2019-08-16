require 'rails_helper'

RSpec.describe Giver, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:giver)).to be_valid
  end
  it 'is not valid without a region' do
    expect(build(:giver, region: nil)).to_not be_valid
  end
end
