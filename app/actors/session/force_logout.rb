class Session::ForceLogout < Actor
  input :user_ids, type: Array

  def call
    ActiveRecord::SessionStore::Session.find_each do |session|
      if session.data.is_a?(Hash) && user_ids.include?(session.data["user_id"])
        session.destroy
      end
    end
  end
end
