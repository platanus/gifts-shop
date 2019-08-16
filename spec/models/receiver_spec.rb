require 'rails_helper'

RSpec.describe Receiver, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:receiver)).to be_valid
  end
  it 'is not valid without a name' do
    expect(build(:receiver, name: nil)).to_not be_valid
  end
  it 'is not valid without a giver' do
    expect(build(:receiver, giver: nil)).to_not be_valid
  end
  it 'is not valid without a relation' do
    expect(build(:receiver, relation: nil)).to_not be_valid
  end
end
