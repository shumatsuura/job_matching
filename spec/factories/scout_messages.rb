FactoryBot.define do
  factory :scout_message do
    title { "MyString" }
    body { "MyText" }
    scout { nil }
    company { nil }
    user { nil }
    read { false }
  end
end
