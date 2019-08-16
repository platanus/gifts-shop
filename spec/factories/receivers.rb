FactoryBot.define do
  factory :receiver do
    name { "MyString" }
    email { "MyString" }
    giver
    relation
  end
end
