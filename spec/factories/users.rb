FactoryBot.define do
  factory :user, class: User do
    username {Faker::Internet.username}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
  end
end
