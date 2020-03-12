FactoryBot.define do
  factory :work_experience do
    company { "MyString" }
    position { "MyString" }
    period_start { "2020-03-12 11:15:39" }
    period_end { "2020-03-12 11:15:39" }
    currently_employed { false }
    description { "MyText" }
    salary { 1 }
    user { nil }
  end
end
