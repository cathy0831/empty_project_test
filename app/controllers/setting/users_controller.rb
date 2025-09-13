class Setting::UsersController < ApplicationController
  before_action -> { permission_check("user", "search") }, only: [:index]
  before_action -> { permission_check("user", "edit") }, except: [:index]
  before_action :raleted_data, only: [:index, :new, :edit]

  def index
    actor = User::List.result(search_params)
    if actor.success?
      @pagy, users = pagy_array(actor.users)
      @users = user_blueprint(users, view: :list)
    else
      @users = []
    end
  end

  def new
    @user = User.new(state: "enable")
  end

  def edit
    actor = User::Find.result(user_id: params[:id])
    if actor.success?
      @user = user_blueprint(actor.user, view: :form)
    else
      head :not_found
    end
  end

  def create
    actor = User::Create.result(form_params)
    render_json(actor)
  end

  def update
    actor = User::Update.result(form_params)
    render_json(actor, data: { require_logout: require_logout(actor) })
  end

  private

  def require_logout(actor)
    actor.success? &&
      actor.need_force_logout &&
      actor.user == current_user
  end

  def raleted_data
    permissions = Permission::List.call.permissions
    @permissions = PermissionBlueprint.render_as_hash(permissions)
  end

  def user_blueprint(users, view: nil)
    UserBlueprint.render_as_hash(users, view:)
  end

  def search_params
    {
      type: "setting",
      account: params[:account],
      name: params[:name],
    }
  end

  def form_params
    {
      user_id: params[:id],
      params: params.permit(:account,
                            :name,
                            :password,
                            :permission_id,
                            :note,
                            :state),
    }
  end
end
