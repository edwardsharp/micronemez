class AddFieldsToKalturaVideo < ActiveRecord::Migration
  def change
    #THIS IS A SINGLE MIGRATION BECAUSE THIS FIELDS ARE SPECIFIC TO CE 5.0.0
    add_column :kaltura_videos, :conversionProfileId, :string
    add_column :kaltura_videos, :operationAttributes, :string
    add_column :kaltura_videos, :partnerSortValue, :string
    add_column :kaltura_videos, :referenceId, :string
    add_column :kaltura_videos, :replacedEntryId, :string
    add_column :kaltura_videos, :replacementStatus, :string
    add_column :kaltura_videos, :replacingEntryId, :string
    add_column :kaltura_videos, :rootEntryId, :string 
  end
end
