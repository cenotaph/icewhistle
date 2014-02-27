 # -*- encoding : utf-8 -*-
ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes title, body, extended
  has created_at, updated_at
end
