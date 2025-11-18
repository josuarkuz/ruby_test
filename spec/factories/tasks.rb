FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    status { "MyString" }
    project { nil }
    assignee_type { "MyString" }
    assignee_id { "" }
  end
end
