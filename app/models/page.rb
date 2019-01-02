class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => [:history, :slugged]
  scope :published, -> () { where(published: true) }
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  
  def update_image_attributes
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
  
end
