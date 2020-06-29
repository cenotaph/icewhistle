class Registration < ApplicationRecord
  belongs_to :event
  validates :name, :email, :phone, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  include Discard::Model
end
