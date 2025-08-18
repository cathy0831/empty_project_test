class Permission::Update < Actor
  input :params
  input :permission_id

  output :permission

  play Permission::Find,
       :check_default,
       :update_permission

  def check_default
    return unless %w[default system].include?(permission.state)

    fail!(error: I18n.t("actor.permission.default_permission"))
  end

  def update_permission
    if permission.update(permission_params)
      self.permission = permission
    else
      fail!(error: permission.errors.full_messages.join(", "))
    end
  end

  private

  def permission_params
    {
      name: params[:name],
      content: JSON.parse(params[:content]),
      note: params[:note],
      state: params[:state],
    }
  end
end
