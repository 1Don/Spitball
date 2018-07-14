Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    '6l9dVLpwCsA5xSTWOGSua3vGfxU-dVNw',
    'YOUR_CLIENT_SECRET',
    'spitball.auth0.com',
    callback_path: "/auth/oauth2/callback",
    authorize_params: {
      scope: 'openid profile',
      audience: 'https://spitball.auth0.com/userinfo'
    }
  )
end