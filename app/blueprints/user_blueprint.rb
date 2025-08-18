class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :state

  view :list do
    fields :account
    association :permission, blueprint: PermissionBlueprint
  end

  view :show do
    include_view :list
  end
end
