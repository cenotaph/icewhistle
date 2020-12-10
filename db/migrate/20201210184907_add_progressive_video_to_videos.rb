class AddProgressiveVideoToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :progressive_video, :boolean
  end
end
