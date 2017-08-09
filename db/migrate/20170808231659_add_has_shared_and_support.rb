class AddHasSharedAndSupport < ActiveRecord::Migration
  def change
    add_column :users, :has_shared, :boolean, null: false, default: false
    add_column :users, :is_supporter, :boolean, null: false, default: false
  end
end
