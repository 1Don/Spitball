OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['289714810643-cng8l1klcojnclpvmamnhv7mgb3qre39.apps.googleusercontent.com'], ENV['39PPXfT4MYeta9lPSMnv2qo6'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

:provider_ignores_state => true