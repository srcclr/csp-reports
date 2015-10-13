FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User #{n}"}
    sequence(:email) { |n| "user_#{n}@mail.com" }

    username_lower { username.downcase }
    email_digests { SecureRandom.uuid }
    trust_level { 2 }
    external_links_in_new_tab { true }
  end
end
