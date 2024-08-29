FactoryBot.define do
  factory :task do
    title { "MyString" }
    user { nil }
    dietitian { nil }
    patient { nil }
  end
end
