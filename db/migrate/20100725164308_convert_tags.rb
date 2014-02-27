class ConvertTags < ActiveRecord::Migration
  def self.up
    add_column :taggings, :context, :string
    add_column :taggings, :tagger_id, :integer
    add_column :taggings, :tagger_type, :string
    add_column :taggings, :created_at, :datetime
    execute "UPDATE taggings SET context='tags'"
  end

  def self.down
    remove_column :taggings, :context
    remove_column :taggings, :tagger_id
    remove_column :taggings, :tagger_type
  end
end
