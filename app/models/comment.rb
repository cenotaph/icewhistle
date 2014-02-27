class Comment < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  validates_presence_of :realname, :body
end
