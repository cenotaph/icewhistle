CarrierWave.configure do |config|  
    config.storage = :aws
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false    
    config.aws_credentials = {
      :access_key_id      => ENV.fetch('wasabi_access_key'),
      :secret_access_key  => ENV.fetch('wasabi_secret'),
      region: 'us-east-1'
    }
    config.asset_host = "https://icewhistle-content.s3.wasabisys.com"
    config.aws_acl    = 'public-read'

    config.aws_bucket = "icewhistle-content"
    config.aws_acl    = :public_read
    # config.s3_region = 'eu-west-1'
end
Aws.config.update({endpoint: 'https://s3.wasabisys.com'})