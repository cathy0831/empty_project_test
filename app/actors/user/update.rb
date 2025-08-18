class User::Update < Actor
  input :user_id
  input :params

  output :user

  play User::Find,
       :update_user

  def update_user
    if user.update(user_params)
      self.user = user
    else
      fail!(error: user.errors.full_messages.join(", "))
    end
  end

  private

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
