class Link < ActiveRecord::Base
  belongs_to :category
  # file_column :imagefilename
end
