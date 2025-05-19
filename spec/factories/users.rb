FactoryBot.define do
  factory :user do
    username { "user#{SecureRandom.hex(3)}" }
    password { "password123" }
  end
end
