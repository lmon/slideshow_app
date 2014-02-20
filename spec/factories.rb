FactoryGirl.define do
  factory :user do
    name     "Testy McTesterson"
    email    "Testy@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end