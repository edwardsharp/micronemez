class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :catnum
      t.string :title
      t.string :location
      #t.string :tags
      #t.string :keywords
      t.string :description
      
      #thumbz, if they exist...
      t.string :thumbnail_saveto
      t.string :thumbnail_url
      
      #filez
      t.string :file_saveto
      t.string :file_pub_url
      t.string :file_cdn_url
      
      #foreign keyz
      t.integer :user_id
      t.integer :tag_id
      t.integer :keyword_id
      t.integer :sort
      t.string :kaltura_mediaId

      t.timestamps
    end
    
    add_index :audios, :catnum, :unique => true
    add_index :audios, :user_id
    add_index :audios, :tag_id
    add_index :audios, :keyword_id
    add_index :audios, :sort
    add_index :audios, :kaltura_mediaId
  end

end
