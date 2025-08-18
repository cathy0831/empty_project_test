class Permission::List < Actor
  output :permissions
  output :setting_permissions

  play  :grep_permissions,
        :grep_setting_permissions

  def grep_permissions
    permissions = Permission.where(state: %w[enable default])
    self.permissions = permissions
  end

  def grep_setting_permissions
    permissions = Permission.where(state: %w[enable disable default])
    self.setting_permissions = permissions.order(state: :desc)
  end
end
