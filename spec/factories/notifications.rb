FactoryBot.define do
  factory :notification do
    user_id { 1 }
    company_id { 1 }
    body { "MyString" }
    read { false }
    target { "MyString" }
  end
end
