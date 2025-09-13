FactoryBot.define do
  factory :user do
    association :permission  # 預設會建立一個 permission
    
    name { FFaker::Name.name }
    account { FFaker::Internet.user_name }
    password { "password123" }
    password_digest { BCrypt::Password.create(password) }
    note { FFaker::Lorem.sentence }
    state { "enable" }
    session_token { nil }

    trait :inactive do
      state { "disable" }
    end

    trait :system do
      association :permission, :with_all_modules
      state { "system" }
    end

    trait :admin do
      association :permission, :with_all_modules
    end
  end
end
