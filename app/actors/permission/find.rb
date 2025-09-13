class Permission::Find < Actor
  input :permission_id

  output :permission

  def call
    self.permission = Permission.find_by(id: permission_id)

    return if permission.present?

    fail!(error: I18n.t("actor.permission.not_found", id: permission_id))
  end
end
