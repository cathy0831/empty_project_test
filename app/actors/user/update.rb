class User::Update < Actor
  input :user_id
  input :params

  output :user
  output :need_force_logout

  play User::Find,
       :update_user,
       :force_logout

  def update_user
    self.need_force_logout = permission_or_password_changed?

    return if user.update(user_params)

    fail!(error: user.formatted_errors)
  end

  def force_logout
    return unless need_force_logout

    Session::ForceLogout.call(user_ids: [user.id])
  end

  private

  def permission_or_password_changed?
    new_permission_id = params[:permission_id]&.to_i
    (user.permission_id != new_permission_id) || params[:password].present?
  end

  def user_params
    params.permit(
      :account,
      :name,
      :password,
      :permission_id,
      :note,
      :state,
    )
  end
end
