class AddMediaidToKalturaVideo < ActiveRecord::Migration
  def change
  	add_column :kaltura_videos, :mediaId, :string
  	add_column :kaltura_videos, :mediaType, :string
  end
end
