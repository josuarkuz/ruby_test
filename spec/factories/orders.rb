FactoryBot.define do
  factory :order do
    user { nil }
    status { 1 }
    total_cents { 1 }
  end
end
