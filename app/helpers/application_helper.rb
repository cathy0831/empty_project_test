module ApplicationHelper
  include Pagy::Frontend

  def current_user_permission
    current_user.permission.content
  end

  def search_perm(perm)
    perm = current_user_permission[perm]
    perm && perm["search"] == "1"
  end

  def edit_perm(perm)
    perm = current_user_permission[perm]
    perm && perm["edit"] == "1"
  end
end
