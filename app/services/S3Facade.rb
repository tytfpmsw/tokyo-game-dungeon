require 'aws-sdk-s3'

class S3Facade
  
  def s3
    @s3 ||= Aws::S3::Resource.new(
      region: Rails.application.credentials.aws_s3[:region],
      access_key_id: Rails.application.credentials.aws_s3[:access_key],
      secret_access_key: Rails.application.credentials.aws_s3[:secret_access_key]
    )
  end

  def initialize
    @bucket = s3.bucket(Rails.application.credentials.aws_s3[:bucket])
  end

  # S3上のオブジェクトをコピーする
  def copy_object(source_key, destination_key)
    source_object = @bucket.object(source_key)
    destination_object = @bucket.object(destination_key)

    # Copy the object
    destination_object.copy_from(source_object)
  end

  def get_object_url(bucket_url, object_key)
    "#{bucket_url}#{object_key}"
  end
end