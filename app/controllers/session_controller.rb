class SessionController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  protect_from_forgery except: [:new, :create]

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
      redirect_to (params[:redirect_path] || root_path), notice: t(".success")
    else
      flash[:alert] = actor.error
      render :login, layout: false, status: :unauthorized
    end
  end

  # DELETE "/logout"
  def destroy
    sign_out if session[:user_id]
    redirect_to login_path, notice: t(".success")
  end

  private

  def user_params
    {
      account: params[:account],
      password: params[:password],
    }
  end
end
