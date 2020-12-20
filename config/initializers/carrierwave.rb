# frozen_string_literal: true

# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage NullStorage
    config.enable_processing = false
  elsif Rails.env.production? || Rails.env.staging? || (Rails.env.development? && ENV.fetch("S3_TESTING", false))

    config.fog_credentials = {
        provider:              "AWS",
        aws_access_key_id:     ENV["AWS_S3_ACCESS_KEY"],
        aws_secret_access_key: ENV["AWS_S3_SECRET_ACCESS_KEY"],
        region:                "ap-northeast-1",
        path_style:            true
    }

    config.fog_public = true
    config.fog_attributes = { "Cache-Control" => "public, max-age=15552000" }

    config.fog_directory = ENV["AWS_S3_DIRECTORY"]
    config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV["AWS_S3_DIRECTORY"]}"
    config.storage = :fog
    config.cache_storage = :fog
  else
    config.storage = :file
    config.cache_storage = :file
  end
end