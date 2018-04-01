FactoryBot.define do
  factory :user do
    email 'user@example.com'
    password 'passw0rd'
    score 0
    streak 0
  end
end