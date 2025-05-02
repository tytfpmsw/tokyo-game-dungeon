require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = Rails.application.credentials.aws_s3[:bucket]
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws_s3[:access_key],
      aws_secret_access_key: Rails.application.credentials.aws_s3[:secret_access_key],
      region: Rails.application.credentials.aws_s3[:region],
      path_style: true
    }
  end  
end

