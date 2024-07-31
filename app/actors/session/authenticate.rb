class Session::Authenticate < Actor
  input :account
  input :password

  output :user

  def call
    user = grep_user(account)
    invaild_user unless authenticate?(user, password)

    self.user = user
  end

  private

  def authenticate?(user, _password)
    return false if user.nil?

    # return false unless user.authenticate(password)
    # return false unless user.enable?

    true
  end

  def grep_user(account)
    User.find_by(account:)
  end

  def invaild_user
    fail!(error: I18n.t("actor.authenticate.invalid_user"))
  end
end
