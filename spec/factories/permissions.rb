FactoryBot.define do
  factory :permission do
    name { FFaker::Name.name }
    state { "enable" }
    content { PermissionHelper.permission_with_modules([]) }

    trait :with_all_modules do
      all_permission = %i[permission user customer quote_setting product quotation]
      content { PermissionHelper.permission_with_modules(all_permission) }
    end
  end
end
