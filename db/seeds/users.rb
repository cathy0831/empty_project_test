def create_amas_user(id:, account:, name:)
  user = User.find_or_initialize_by(id:)
  user.password = "477cd91f" # AMAS 預設密碼雜湊
  user.update!(
    account:,
    name:,
    state: "system",
    permission_id: -1,
  )
  user
end

# 呼叫主程式
Seed_Logger.info "🔐 建立預設系統帳號..."
create_amas_user(id: -1, account: "AMASSYS",  name: "AMASsys")
create_amas_user(id: -2, account: "AMASUSER", name: "AMASuser")
Seed_Logger.info "✅ 預設帳號建立完成"
