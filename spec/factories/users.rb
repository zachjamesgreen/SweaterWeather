FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    api_key { "" }
  end
end
