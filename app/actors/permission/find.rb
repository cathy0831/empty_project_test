class Permission::Find < Actor
  input :permission_id

  output :permission

  def call
    permission = Permission.find_by(id: permission_id)
    self.permission = permission
  end
end
