class Setting::PermissionsController < ApplicationController
  before_action -> { permission_check("permission", "search") }, only: [:index]
  before_action -> { permission_check("permission", "edit") }, except: [:index]

  def index
    actor = Permission::List.result(search_params)
    if actor.success?
      @pagy, permissions = pagy_array(actor.permissions)
      @permissions = permission_blueprint(permissions, view: :list)
    else
      @permissions = []
    end
  end

  def new
    @permission = Permission.new(state: "enable")
  end

  def edit
    actor = Permission::Find.result(permission_id: params[:id])
    if actor.success?
      @permission = permission_blueprint(actor.permission, view: :form)
    else
      head :not_found
    end
  end

  def create
    actor = Permission::Create.result(form_params)
    render_json(actor)
  end

  def update
    actor = Permission::Update.result(form_params)
    render_json(actor, data: { require_logout: require_logout?(actor) })
  end

  private

  def require_logout?(actor)
    actor.success? &&
      actor.users.include?(current_user)
  end

  def permission_blueprint(permissions, view: nil)
    PermissionBlueprint.render_as_hash(permissions, view:)
  end

  def search_params
    { type: "setting" }
  end

  def form_params
    {
      permission_id: params[:id],
      params: params.permit(:name,
                            :content,
                            :note,
                            :state),
    }
  end
end
