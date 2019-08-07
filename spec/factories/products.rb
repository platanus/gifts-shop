FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1.5 }
    clicks { "" }
    link { "MyString" }
    clicks_cost { 1.5 }
    store { nil }
  end
end
