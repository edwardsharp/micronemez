class AddUrlzAndWhatnotToNodes < ActiveRecord::Migration
  def change

    add_column :nodes, :thumbnail_url, :string
    add_column :nodes, :file_saveto, :string
    add_column :nodes, :file_pub_url, :string
    add_column :nodes, :file_cdn_url, :string

    add_column :nodes, :asset_upload_file_name, :string    
    add_column :nodes, :asset_upload_content_type, :string    
    add_column :nodes, :asset_upload_file_size, :string     
    add_column :nodes, :asset_upload_updated_at, :string    

    add_column :nodes, :catnum, :string

    add_column :nodes, :location, :string

    add_column :nodes, :user_id, :integer

    add_column :nodes, :tag_id, :integer

    add_column :nodes, :keyword_id, :integer

    add_column :nodes, :is_public, :boolean

    add_column :nodes, :description, :text

    add_column :nodes, :schedule_id, :text

  end
end
