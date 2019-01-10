class Registration < ApplicationRecord
  belongs_to :event
  validates :name, :email, :phone, presence: true
  validates :email, uniqueness: true
  include Discard::Model
end
