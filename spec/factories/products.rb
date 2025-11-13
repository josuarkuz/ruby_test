FactoryBot.define do
  factory :product do
    name { "MyString" }
    sku { "MyString" }
    price_cents { 1 }
    status { 1 }
  end
end
