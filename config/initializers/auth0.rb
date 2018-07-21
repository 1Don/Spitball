Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    '6l9dVLpwCsA5xSTWOGSua3vGfxU-dVNw',
    'P8_l1dz2wkz6Bzv-EkE_rDgdt95iX7thNii8emN76NCV_nKitPM-VnaKMJAS3iqH',
    'spitball.auth0.com',
    callback_path: "/auth/oauth2/callback",
    authorize_params: {
      scope: 'openid profile',
      audience: 'https://spitball.auth0.com/userinfo'
    }
  )
end
