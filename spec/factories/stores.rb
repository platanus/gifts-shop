FactoryBot.define do
  factory :store do
    sequence :email do |n|
      "name_#{n}@example.com"
    end
    password { '123456' }
    region
    name { 'SuperStore' }
    has_enough_balance { false }
  end
end
