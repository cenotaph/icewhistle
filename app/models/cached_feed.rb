class CachedFeed < ActiveRecord::Base
  attr_accessible :parsed_feed, :uri
  validates_presence_of :uri, :parsed_feed
  validates_uniqueness_of :uri
  serialize :parsed_feed, Hash # note that if this exceeds a certain KB size, it will likely fail (thinking it's a String)
end