module PermissionHelper
  def self.permission_with_modules(enabled_modules = [])
    enabled_set = enabled_modules.to_set

    PERMISSION_ITEMS.each_with_object({}) do |item, perm|
      module_name = item[:module].to_s
      is_enabled = enabled_set.include?(item[:module].to_sym)
      default = is_enabled ? "1" : "0"

      perm[module_name] = item[:actions].each_with_object({}) do |action, actions_hash|
        actions_hash[action.to_s] = default
      end
    end
  end
end
