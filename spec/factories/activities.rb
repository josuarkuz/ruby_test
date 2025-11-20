FactoryBot.define do
  factory :activity do
    record_type { "MyString" }
    record_id { 1 }
    action { "MyString" }
    actor_id { 1 }
    metadata { "" }
  end
end
