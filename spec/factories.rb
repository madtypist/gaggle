FactoryGirl.define do
  factory :user do |u|
    u.username "testuser1"
    u.email "thisis@fake.com"
    u.password "password"
    u.password_confirmation "password"
  end
end
