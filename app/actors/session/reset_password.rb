class Session::ResetPassword < Actor
  input :user
  input :old_password
  input :new_password

  play :check_old_password,
       :check_new_password,
       :update_password

  private

  def check_old_password
    return if user.authenticate(old_password)

    fail!(error: I18n.t("actor.session.invalid_old_password"))
  end

  def check_new_password
    return if new_password.present?

    fail!(error: I18n.t("actor.session.invalid_new_password"))
  end

  def update_password
    user.password = new_password
    return if user.save

    fail!(error: user.formatted_errors)
  end
end
