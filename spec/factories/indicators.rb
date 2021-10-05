FactoryBot.define do
  factory :indicator do
    value_min { 1 }
    value_max { 1 }
    description { "MyString" }
    gender { nil }
  end
end
