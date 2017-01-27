class IncreaseTwitterIdSize < ActiveRecord::Migration
  def change
    remove_column :tweets, :twitter_id
    add_column :tweets, :twitter_id, :integer, limit: 8
  end
end
