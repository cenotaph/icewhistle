class Crumble < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  extend FriendlyId
  friendly_id :title, :use => [:finders, :slugged]
 
  mount_uploader :icon, ImageUploader
  
  mount_uploader :attachment, AttachmentUploader
  # has_attached_file :icon, :styles => {  :thumb => "120x120>" },
  #  :path => ":rails_root/public/crumble_files/:id/icon/:basename.:extension", 
  #  :url => "/crumble_files/:id/icon/:basename.:extension"
  # 
  # has_attached_file :attachment,  :styles => {  :thumb => "120x120>", :medium => "500x500>" },
  #  :path => ":rails_root/public/crumble_files/:id/:basename.:extension", 
  #  :url => "/crumble_files/:id/:basename.:extension", :whiny => false
  has_many :comments, :as => :item
  acts_as_taggable_on :tags
  

  
  def body
    description
  end
  
  def extended
    nil
  end
  
  def name
    title
  end
  
  def image
    icon
  end
  
  def image?
    icon?
  end
  
  def photos
    []
  end
  
  def related
    out = []
    tags.each do |tag|
      out << Crumble.tagged_with(tag)
    end
    out.flatten.uniq.delete_if{|x| x == self}
  end

end
