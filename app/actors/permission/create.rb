class Permission::Create < Actor
  input :params

  output :permission

  def call
    self.permission = Permission.new(permission_params)

    return if permission.save

    fail!(error: permission.formatted_errors)
  end

  private

  def permission_params
    {
      name: params[:name],
      content: parse_content(params[:content]),
      state: params[:state],
    }
  end

  def parse_content(raw_content)
    if raw_content.nil? || raw_content.strip.empty?
      fail!(error: "權限內容不可為空")
    end

    JSON.parse(raw_content)
  rescue JSON::ParserError => e
    fail!(error: "錯誤JSON格式: #{e.message}")
  end
end
