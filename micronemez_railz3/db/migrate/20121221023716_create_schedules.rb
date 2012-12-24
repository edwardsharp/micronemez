class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.text :description
      t.boolean :live
      t.string :channel
      t.string :status

      t.timestamps
    end
  end
end
