FactoryBot.define do
  factory :deposit do
    organization
    store
    amount { 1000000 }
    amount_currency { 'CLP' }
    deposit_time { Date.current }
  end
end
