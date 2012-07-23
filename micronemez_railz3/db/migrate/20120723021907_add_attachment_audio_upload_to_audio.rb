class AddAttachmentAudioUploadToAudio < ActiveRecord::Migration
  def change
    add_column :audios, :audio_upload_file_name, :string
    add_column :audios, :audio_upload_content_type, :string
    add_column :audios, :audio_upload_file_size, :integer
    add_column :audios, :audio_upload_updated_at, :datetime
  end
end
