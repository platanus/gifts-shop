FactoryBot.define do
  factory :deposit do
    organization
    store
    amount { 1000000 }
    amount_currency { 'CLP' }
    deposit_time { Date.current }
  end

  trait :without_execute_store_deposit do
    after(:build) { |d| d.class.skip_callback(:save, :after, :execute_store_deposit, raise: false) }
  end
end
