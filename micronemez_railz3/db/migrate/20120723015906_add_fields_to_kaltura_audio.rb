class AddFieldsToKalturaAudio < ActiveRecord::Migration
  def change
    #THIS IS A SINGLE MIGRATION BECAUSE THIS FIELDS ARE SPECIFIC TO CE 5.0.0
    add_column :kaltura_audios, :conversionProfileId, :string
    add_column :kaltura_audios, :operationAttributes, :string
    add_column :kaltura_audios, :partnerSortValue, :string
    add_column :kaltura_audios, :referenceId, :string
    add_column :kaltura_audios, :replacedEntryId, :string
    add_column :kaltura_audios, :replacementStatus, :string
    add_column :kaltura_audios, :replacingEntryId, :string
    add_column :kaltura_audios, :rootEntryId, :string 
  end
end
