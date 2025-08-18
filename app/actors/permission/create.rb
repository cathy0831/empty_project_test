class Permission::Create < Actor
  input :params

  output :permission

  def call
    permission = Permission.new(permission_params)
    if permission.save
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
