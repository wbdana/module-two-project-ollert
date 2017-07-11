class CreateManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :managers do |t|
      t.string :name
      t.integer :store_id

      t.timestamps
    end
  end
end
