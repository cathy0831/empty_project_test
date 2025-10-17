class CustomerBlueprint < Blueprinter::Base
  identifier :id

  fields :account, :name, :note, :state, :created_at, :updated_at

  field :permission_name do |customer|
    customer.permission&.name
  end

  field :permission_id do |customer|
    customer.permission_id
  end

  view :list do
    fields :account, :name, :state, :created_at
    field :permission_name do |customer|
      customer.permission&.name
    end
  end

  view :form do
    fields :account, :name, :note, :state, :permission_id
    field :permission_name do |customer|
      customer.permission&.name
    end
  end
end
