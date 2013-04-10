FactoryGirl.define do
  factory :user do |u|
    u.username "testuser1"
    u.email "thisis@fake.com"
    u.password "password"
    u.password_confirmation "password"
  end

  factory :movie do |m|
    m.title "Best Movie Ever"
    m.summary "This is a great movie. Stuff blows up"
    m.year 2000
  end
end
