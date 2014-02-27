class Post < ActiveRecord::Base
  belongs_to :grouping
  has_many :comments, :as => :item

  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :title, :use => [:finders, :slugged]
  has_many :photos, as: :item
    
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  
  scope :published, -> () { where(published: true) }    
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }
  
  def fulltext
  	if self.extended.blank?
		  return self.body
	  else
		  return self.body + "<br />" + self.extended
	  end
  end
  
  def name
    title
  end
  
  def related
    out = []
    tags.each do |tag|
      out << Post.tagged_with(tag)
    end
    out.flatten.uniq.delete_if{|x| x == self}
  end
  
  def update_image_attributes
    if image.present?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
    
end
