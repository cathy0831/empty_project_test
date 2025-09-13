module ApplicationHelper
  include Pagy::Frontend

  def current_user_permission
    current_user.permission.content
  end

  def search_perm(module_perm)
    perm = current_user_permission[module_perm]
    perm && perm["search"] == "1"
  end

  def edit_perm(module_perm)
    perm = current_user_permission[module_perm]
    perm && perm["edit"] == "1"
  end
end
