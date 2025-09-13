module SessionHelper
  def setting_path
    SETTING_MODULES.each do |mod|
      return "setting/#{mod}s" if search_perm(mod)
    end

    "" # 沒有任何權限就回空字串
  end
end
