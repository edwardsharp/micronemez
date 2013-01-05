class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      
      t.text :description
      t.boolean :is_live_stream
      t.string :channel
      t.string :status
      t.string :url
      t.string :type
      t.string :extended
      t.string :metadata

      #dhtmlxScheduler related
      t.string :title
      t.datetime :start
      t.datetime :end

      t.string :event_pid
      t.string :event_length
      t.string :rec_pattern
      t.string :rec_type
      
      t.string :single_checkbox
      t.string :radiobutton_option
      t.string :custom_type

      t.timestamps
    end
  end
end
