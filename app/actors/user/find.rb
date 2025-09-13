class User::Find < Actor
  input :user_id

  output :user

  def call
    self.user = User.find_by(id: user_id)

    return if user.present?

    fail!(error: I18n.t("actor.user.not_found", id: user_id))
  end
end
