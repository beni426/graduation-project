CarrierWave.configure do |config|
      require 'carrierwave/storage/abstract'
      require 'carrierwave/storage/file'
      require 'carrierwave/storage/fog'
    
      config.storage :fog
      config.fog_provider = 'fog/aws'
      config.fog_credentials = {
          provider:              'AWS',
          aws_access_key_id:     ENV["AKIA5TECMGFXXCE3Q4H7"],
          aws_secret_access_key: ENV["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"],
          region:                'ap-northeast-1',
          path_style:            true,
      }
    
      config.fog_public     = false
      config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
    
      case Rails.env
        when 'production'
          config.fog_directory = 'kiraibar-production'
          config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/kiraibar-production'
        when 'development'
          config.fog_directory = 'kiraibar-production'
          config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/kiraibar-production'
      end
    end