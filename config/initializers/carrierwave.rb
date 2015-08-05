CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',                       # required
    aws_access_key_id:      ENV['AWS_KEY'],              # required
    aws_secret_access_key:  ENV['AWS_SECRET']            # required
  }
  config.fog_directory  = "versosperfectos2-#{Rails.env}"    # required
  config.fog_public     = true                                        # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end
