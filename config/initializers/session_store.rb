Rails.application.config.session_store :active_record_store,
  key: "_project_session",
  expire_after: 14.days,
  secure: Rails.env.production?,
  httponly: true,
  same_site: :strict
