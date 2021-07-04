class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.datetime :day
      t.integer :manager_id
      t.integer :start_time
      t.integer :end_time
      t.timestamps
    end
  end
end
