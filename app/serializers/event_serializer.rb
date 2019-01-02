class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_at, :end_at, :link1, :link2, :name, :extra_date, :slug,  :location, :latitude, :longitude, :expires, :registration, :description, :question1, :question2, :question3, :reg_limit
  has_many :photos
  has_many :registrations
end
