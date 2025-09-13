class Permission::Update < Actor
  input :params
  input :permission_id

  output :permission
  output :users

  play Permission::Find,
       :check_default,
       :update_permission,
       :force_logout

  def check_default
    return unless %w[system].include?(permission.state)

    fail!(error: I18n.t("actor.permission.default_permission"))
  end

  def update_permission
    return if permission.update(permission_params)

    fail!(error: permission.formatted_errors)
  end

  def force_logout
    self.users = permission.users
    user_ids = users.pluck(:id)

    Session::ForceLogout.call(user_ids: user_ids)
  end

  private

  def permission_params
    {
      name: params[:name],
      content: parse_content(params[:content]),
      state: params[:state],
    }.compact
  end

  def parse_content(raw_content)
    return nil if raw_content.nil? || raw_content.strip.empty?

    JSON.parse(raw_content)
  rescue JSON::ParserError => e
    fail!(error: "錯誤JSON格式: #{e.message}")
  end
end
