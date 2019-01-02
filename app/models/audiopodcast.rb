class Audiopodcast < ApplicationRecord
  belongs_to :item, polymorphic: true
  validates_presence_of :url
end
