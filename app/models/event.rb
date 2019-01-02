class Event < ApplicationRecord
  validates :start_at, :end_at, :name, :description, presence: true
  has_many :photos, as: :item
  has_many :registrations
  extend FriendlyId
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true  
  friendly_id :name, :use => [:history, :slugged, :finders]
  scope :future, -> () { where(["start_at <= ?", Time.current.utc]) }

end
