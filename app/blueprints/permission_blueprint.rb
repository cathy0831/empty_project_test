class PermissionBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :list do
    fields :content, :state
  end

  view :form do
    include_view :list
  end
end
