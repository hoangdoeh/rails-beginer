FactoryBot.define do
  factory :todo do
    name { "Test todo" }
    deadline { Date.tomorrow }
    status { 0 }
    user_id { 1 }
  end
end
