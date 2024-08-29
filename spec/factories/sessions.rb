FactoryBot.define do
  factory :session do
    weight { "9.99" }
    height { "9.99" }
    waist { "9.99" }
    hip { "9.99" }
    imc { "9.99" }
    desired_imc { "9.99" }
    date { "2021-05-13" }
    dietitian_id { 1 }
    patient { nil }
  end
end
