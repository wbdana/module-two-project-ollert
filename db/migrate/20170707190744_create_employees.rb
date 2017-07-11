class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.integer :store_id
      t.boolean :is_manager, :default => false
      t.string :password_digest
      t.timestamps
    end
  end
end
