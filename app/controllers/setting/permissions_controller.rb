class Setting::PermissionsController < ApplicationController
  def index
    @permissions = []
  end

  def new
    @permission = {}
  end

  def edit
    @permission = {}
  end

  def create; end
  def update; end
end
