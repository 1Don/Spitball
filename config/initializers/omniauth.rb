OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    '289714810643-cng8l1klcojnclpvmamnhv7mgb3qre39.apps.googleusercontent.com',
    '39PPXfT4MYeta9lPSMnv2qo6',
    callback_path: "/auth/google_oauth2/callback"
  )

  provider(
    :linkedin,
    '81sxdd3nr9bp6x',
    'D7gkTWNEVMEPUCyn',
    callback_path: "/auth/linkedin/callback"
  )


  provider(
  	:twitter,
  	'hiDLRtGo8kfJB5O9lOMCE4gop',
  	'niWUXeDD99SAkcDJ5s3ticit8txCr8fpDtTvYWeJIBX9SQn5DJ',
    callback_path: "/auth/twitter/callback"
  )

  
end
