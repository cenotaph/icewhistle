class Post < ActiveRecord::Base
  belongs_to :grouping
  has_many :comments, :as => :item

  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :title, :use => [:history, :slugged, :finders]
  has_many :photos, as: :item
  has_many :videos, as: :item
  has_many :audiopodcasts, as: :item
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  validates_presence_of :title, :body
  
  scope :published, -> () { where(published: true) }    
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :videos, :reject_if => proc {|x| x['url'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :audiopodcasts, :reject_if => proc {|x| x['url'].blank? }, :allow_destroy => true
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
  
  def enclosures
    out = []
    out << audiopodcasts.map{|x| [x.url, x.bytes.to_s, x.content_type]} unless audiopodcasts.empty?
    out << videos.map{|x| [x.url, x.bytes.to_s, x.content_type]} unless videos.empty?
    out.compact
  end
  
  def previous_post
    Post.where(["id < ?", id]).published.last
  end

  def next_post
    Post.where(["id > ?", id]).published.first
  end
  
  def related
    out = []
    tags.each do |tag|
      out << Post.tagged_with(tag)
    end
    out.flatten.uniq.delete_if{|x| x == self}
  end
  
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
