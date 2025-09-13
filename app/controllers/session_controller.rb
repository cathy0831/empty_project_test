class SessionController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create]
  protect_from_forgery except: [:new, :create]

  # GET "/index"
  def index
    redirect_to login_path and return if current_user.nil?
  end

  # GET "/login"
  def new
    redirect_to root_path and return if current_user.present?

    render :login, layout: false
  end

  # POST "/login"
  def create
    actor = Session::Authenticate.result(user_params)
    if actor.success?
      sign_in(actor.user)
      render json: { status: 0, message: t(".success") }
    else
      render json: { status: -1, message: t(".fail"), error: actor.error }
    end
  end

  # DELETE "/logout"
  def destroy
    sign_out if session[:user_id]
    redirect_to login_path
  end

  # POST "/reset_password"
  def reset_password
    actor = Session::ResetPassword.result(password_params)
    if actor.success?
      sign_out
      render json: { status: 0, message: t(".success") }
    else
      Error_Logger.error "[#{controller_name}##{action_name}] #{actor.error}"
      render json: { status: -1, message: t(".fail"), error: actor.error }
    end
  end

  private

  def user_params
    {
      account: params[:account],
      password: params[:password],
    }
  end

  def password_params
    {
      user: current_user,
      old_password: params[:old_password],
      new_password: params[:new_password],
    }
  end
end
