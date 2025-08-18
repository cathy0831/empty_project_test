class User::Create < Actor
  input :params

  output :user

  def call
    user = User.new(user_params)
    user.save!
    self.user = user
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
