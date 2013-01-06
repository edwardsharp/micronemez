class AddIsPublicToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :is_public, :boolean

  end
end
