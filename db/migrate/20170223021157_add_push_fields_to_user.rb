class AddPushFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :push_provider_id, :string
  end
end
