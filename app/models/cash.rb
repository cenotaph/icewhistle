class Cash < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes

  
  def update_image_attributes
    if image.present?
      self.image_content_type = image.file.content_type
      self.image_size = image.file.size
      self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
    end
  end  
end
