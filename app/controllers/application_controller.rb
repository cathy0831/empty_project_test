class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery
  helper_method :current_user

  before_action :set_current_user
  before_action :authenticate_user!

  # 驗證使用者是否登入
  def authenticate_user!
    return if current_user.present? && current_user.active?

    sign_out
    handle_unauthorized_access(
      message: t("application.unauthenticated"),
      redirect_url: login_path(redirect_path: request.fullpath),
    )
  end

  # 權限檢查
  def permission_check(func, subfunc)
    return if current_user&.permission&.allowed?(func, subfunc)

    handle_unauthorized_access
  end

  # 目前登入的 user（memoization）
  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  # 使用者登入（單裝置）
  def sign_in(user)
    # 刪掉同一個使用者的所有 session（單裝置登入）
    ActiveRecord::SessionStore::Session.find_each do |s|
      s.destroy if s.data.is_a?(Hash) && s.data["user_id"] == user.id
    end

    # 寫入新的 session
    session[:user_id] = user.id
  end

  # 使用者登出
  def sign_out
    Current.user = nil
    reset_session
  end

  # JSON 統一回傳格式
  def render_json(actor, data: nil)
    if actor.success?
      render json: { status: 0, message: t(".success"), data: data }
      flash[:notice] = t(".success")
    else
      Error_Logger.error "[#{controller_name}##{action_name}] #{actor.error}"
      render json: { status: -1, message: t(".fail"), error: actor.error }
    end
  end

  # 統一未授權錯誤處理
  def handle_unauthorized_access(message: t("application.no_permission"), redirect_url: nil, status: :forbidden)
    Error_Logger.warn "[UNAUTHORIZED] #{message} - user: #{current_user&.id}, path: #{request.fullpath}"
    redirect_url ||= request.referer || root_path

    respond_to do |format|
      format.json do
        render json: {
          status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status],
          message: message,
          redirect_url: redirect_url,
        }, status: status
      end
      format.html do
        redirect_to redirect_url, alert: message
      end
    end
  end

  private

  # 設定全域 Current.user
  def set_current_user
    Current.user = current_user
  end
end
