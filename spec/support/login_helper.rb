module LoginHelper
  # 模擬有權限的使用者登入
  def login_as(user = nil)
    user ||= FactoryBot.create(
      :user,
      permission: FactoryBot.create(:permission, :with_all_modules),
    )

    # 使用固定明文密碼登入
    post login_path, params: { account: user.account, password: user.password }

    # reload 確保拿到最新 session_token
    user.reload
  end
end
