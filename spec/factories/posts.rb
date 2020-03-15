FactoryBot.define do
  factory :post do
    title { "MyString" }
    salary { 1 }
    number_of_recruits { "MyString" }
    position { "MyString" }
    description { "MyText" }
    location { "MyString" }
    company { nil }
  end
end
