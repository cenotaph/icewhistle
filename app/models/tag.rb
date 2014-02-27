# SSS: Implementation of any necessary extensions to the tag class implemented by the acts_as_taggable_on plugin
class Tag 
  

  def self.popular(options = {})
    query = "select tags.id, name, count(*) as count"
    query << " from taggings, tags"
    query << " where tags.id = tag_id AND taggings.context = 'tags'"
    query << " group by tag_id, tags.id, name"
    query << " order by count desc"
    query << " limit #{options[:limit]}" if options[:limit] != nil
    tags = Tag.find_by_sql(query)
  end
  
  def self.context_tags(context)
    # Optimized to use taggings index without a filesort
    Tag.find(Tag.find(:all, :select => "distinct(tags.id)", :joins => [:taggings], :conditions => {"taggings.context" => context}).map(&:id))
  end

  def self.tags_starting_with(start)
    # Match the start on any of the name subparts
    start.downcase!
    Tag.find(:all, :conditions => ["lower(tags.name) like ? OR lower(tags.name) like ?", start + '%', '% ' + start + '%'])
  end

  def self.context_tags_starting_with(context, start)
    # Match the start on any of the name subparts
    # Optimized to use taggings index without a filesort
    start.downcase!
    Tag.find(Tag.find(:all, :select => "distinct(tags.id)", :joins => [:taggings], :conditions => ["taggings.context = ? AND (lower(tags.name) like ? OR lower(tags.name) like ?)", context, start + '%', '% ' + start + '%']).map(&:id))
  end
end
