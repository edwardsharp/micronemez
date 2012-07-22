class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :catnum
      t.string :title
      t.string :location
      #t.string :tags
      #t.string :keywords
      t.string :description
      
      #thumbz
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
    
    add_index :videos, :catnum, :unique => true
    add_index :videos, :user_id
    add_index :videos, :tag_id
    add_index :videos, :keyword_id
    add_index :videos, :sort
    add_index :videos, :kaltura_mediaId

  end
end
