class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.date :date
      t.text :content
      t.text :tags

      t.timestamps
    end
  end
end
