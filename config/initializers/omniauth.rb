OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    '289714810643-cng8l1klcojnclpvmamnhv7mgb3qre39.apps.googleusercontent.com',
    '39PPXfT4MYeta9lPSMnv2qo6',
    callback_path: "/auth/google_oauth2/callback"
  )
end
