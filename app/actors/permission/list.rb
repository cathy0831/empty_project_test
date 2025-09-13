class Permission::List < Actor
  input :type, default: -> { "general" }

  output :permissions

  play :grep_permissions, if: ->(actor) { actor.type.eql? "general" }

  play :grep_setting_permissions, if: ->(actor) { actor.type.eql? "setting" }

  def grep_permissions
    permissions = Permission.where(state: %w[enable default])
    self.permissions = permissions
  end

  def grep_setting_permissions
    permissions = Permission.where(state: %w[enable disable default])
    self.permissions = permissions.order(state: :desc)
  end
end
