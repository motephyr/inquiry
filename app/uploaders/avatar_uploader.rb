class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def store_metadata (version_name = "original")
    if @file
      metadata = ::MagickMetadata.new(@file.path)
      model.image_meta[version_name+'_content_type']        = metadata.image_file_format
      model.image_meta[version_name+'_file_size']           = metadata.file_size
      model.image_meta[version_name+'_width']               = metadata.width
      model.image_meta[version_name+'_height']              = metadata.height
      model.image_meta[version_name+'_filename_suffix']     = metadata.filename_suffix
      model.image_meta[version_name+'_is_transparency']     = metadata.has_transparency?
      model.image_meta[version_name+'_resolution']          = metadata.resolution
      model.image_meta[version_name+'_compression_percent'] = metadata.image_compression_quality
      model.image_meta[version_name+'_file_name']           = metadata.filename_with_suffix
      model.image_meta[version_name+'_unique_color_count']  = metadata.calculated_number_of_unique_colors
      model.image_meta[version_name+'_file_format']
    end
  end

  # store original file metadata
  process :store_metadata

  version :square_large do
    process :resize_to_fill => [480, 480]
    process :store_metadata => "square_large"
  end

  version :square_limit do
    process :resize_to_limit => [555, 986]
    process :store_metadata => "square_limit"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    random_token = Digest::SHA2.hexdigest("#{original_filename}#{Time.now}").first(30)
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, random_token)
    "#{token}.#{model.attach_avatar.file.extension}" if original_filename
  end

end
