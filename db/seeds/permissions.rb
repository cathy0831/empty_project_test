def permission_with_modules(enabled_modules = [])
  enabled_set = enabled_modules.to_set(&:to_sym)

  PERMISSION_ITEMS.each_with_object({}) do |item, perm|
    module_name = item[:module].to_sym
    is_enabled = enabled_set.include?(module_name)
    default = is_enabled ? "1" : "0"

    perm[module_name] = item[:actions].each_with_object({}) do |action, actions_hash|
      actions_hash[action.to_sym] = default
    end
  end
end

# 呼叫主程式

Seed_Logger.info "🔐 建立預設系統權限..."
all_modules = %i[permission user]
permissions = {
  -1 => { name: "AMAS權限", content: permission_with_modules(all_modules), state: "system" },
  1 => { name: "系統管理", content: permission_with_modules(all_modules), state: "enable" },
}

permissions.each do |id, attrs|
  Permission.find_or_initialize_by(id:).update!(attrs)
end
Seed_Logger.info "✅ 預設權限建立完成"
