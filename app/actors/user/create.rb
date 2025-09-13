class User::Create < Actor
  input :params

  output :user

  def call
    self.user = User.new(user_params)

    return if user.save

    fail!(error: user.formatted_errors)
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
