FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1.5 }
    clicks { "" }
    link { "MyString" }
    email { "MyString" }
    clicks_cost { 1.5 }
    store
    novelty { 3 }
    trait :with_image do
      path = Rails.root.join('spec', 'fixtures', 'files', 'example.jpg')
      image { fixture_file_upload(path, 'image/jpg') }
    end
  end
end
