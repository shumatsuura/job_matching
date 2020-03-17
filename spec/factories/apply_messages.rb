FactoryBot.define do
  factory :apply_message do
    body { "MyText" }
    apply { nil }
    user_id { 1 }
    company_id { 1 }
    read { false }
  end
end
