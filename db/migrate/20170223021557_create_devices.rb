class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :user_id
      t.string :push_id
      t.string :platform

      t.timestamps null: false
    end
  end
end
