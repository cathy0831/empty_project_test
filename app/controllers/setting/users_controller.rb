class Setting::UsersController < ApplicationController
  def index
    @users = []
  end

  def new
    @user = {}
  end

  def edit
    @user = {}
  end

  def create; end
  def update; end
end
