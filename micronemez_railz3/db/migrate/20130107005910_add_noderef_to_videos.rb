class AddNoderefToVideos < ActiveRecord::Migration
  def change

  	add_column :videos, :node_id, :integer
    add_column :videos, :node_catnum, :integer

  end
end
