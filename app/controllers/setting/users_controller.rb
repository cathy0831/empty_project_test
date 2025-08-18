class Setting::UsersController < ApplicationController
  before_action -> { permission_check("user", "search") }, only: [:index]
  before_action -> { permission_check("user", "edit") }, except: [:index]
  before_action :raleted_data, only: [:index, :new, :edit]

  def index
    actor = User::List.result(search_params)
    if actor.success?
      @pagy, users = pagy_array(actor.setting_users)
      @users = user_blueprint(users, view: :list)
    else
      @users = []
    end
  end

  def new
    @user = User.new
  end

  def edit
    actor = User::Find.result(user_id: params[:id])
    if actor.success? && actor.user.present?
      @user = user_blueprint(actor.user, view: :show)
    else
      head :not_found
    end
  end

  def create
    actor = User::Create.result(params: form_params)
    render_json(actor)
  end

  def update
    actor = User::Update.result(user_id: params[:id], params: form_params)
    render_json(actor)
  end

  private

  def raleted_data
    permissions = Permission::List.call.permissions
    @permissions = PermissionBlueprint.render_as_hash(permissions)
  end

  def user_blueprint(users, view: nil)
    UserBlueprint.render_as_hash(users, view:)
  end

  def search_params
    {}
  end

  def form_params
    params.permit(
      :account,
      :name,
      :password,
      :permission_id,
      :note,
      :state,
    )
  end
end
