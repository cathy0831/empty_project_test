class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery
  helper_method :current_user
  before_action :authenticate_user!

  def authenticate_user!
    return if authenticate?(current_user)

    sign_out
    redirect_to login_path(redirect_path: request.env["REQUEST_URI"])
  end

  # 檢查權限
  def permission_check(func, subfunc)
    return if current_user.permission.allowed?(func, subfunc)

    redirect_back(fallback_location: root_path, alert: t("application.no_permission"))
  end

  # 使用者登入
  def sign_in(user)
    session[:user_id] = user.id
  end

  # 使用者登出
  def sign_out
    session.delete(:user_id)
  end

  # 目前登入的 user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # 驗證使用者
  def authenticate?(user)
    user.present? && user.enable?
  end

  # 回傳JSON格式
  def render_json(actor, redirect_path = nil)
    if actor.success?
      if redirect_path
        redirect_to redirect_path
      else
        render json: { state: 0, message: t(".success") }
      end
      flash[:notice] = t(".success")
    else
      render json: { state: -1, message: actor.error }, status: :bad_request
    end
  end
end
