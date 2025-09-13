class Setting::ImportController < ApplicationController
  before_action :require_system_user

  def index
    @import_types = ["user"]
  end

  def import
    case params[:import_type]
    when "user"
      # actor = User::Import.result(import_params)
      # render_json(actor)
    else
      render json: { status: -1, message: t(".no_match_type") }
    end
  end

  private

  def require_system_user
    return if current_user&.state&.system?

    handle_unauthorized_access
  end

  def import_params
    {
      file: params[:file],
    }
  end
end
