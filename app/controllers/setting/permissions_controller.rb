class Setting::PermissionsController < ApplicationController
  before_action -> { permission_check("permission", "search") }, only: [:index]
  before_action -> { permission_check("permission", "edit") }, except: [:index]

  def index
    actor = Permission::List.result(search_params)
    if actor.success?
      Rails.logger.debug actor
      @pagy, permissions = pagy_array(actor.setting_permissions)
      @permissions = PermissionBlueprint.render_as_hash(permissions, view: :list)
    else
      @permissions = []
    end
  end

  def new
    @permission = Permission.new
  end

  def edit
    actor = Permission::Find.result(permission_id: params[:id])
    if actor.success? && actor.permission.present?
      @permission = PermissionBlueprint.render_as_hash(actor.permission, view: :show)
    else
      head :not_found
    end
  end

  def create
    actor = Permission::Create.result(params: form_params)
    render_json(actor)
  end

  def update
    actor = Permission::Update.result(permission_id: params[:id], params: form_params)
    render_json(actor)
  end

  private

  def search_params
    {}
  end

  def form_params
    params.permit(
      :name,
      :content,
      :note,
      :state,
    )
  end
end
