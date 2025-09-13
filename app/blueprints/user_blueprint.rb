class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :list do
    fields :account, :state

    association :permission, blueprint: PermissionBlueprint
  end

  view :form do
    include_view :list

    fields :permission_id, :note
  end
end
