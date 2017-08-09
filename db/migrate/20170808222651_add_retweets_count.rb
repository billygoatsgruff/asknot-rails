class AddRetweetsCount < ActiveRecord::Migration
  def change
    add_column :users, :retweets_count, :integer, null: false, default: 0
    add_column :tweets, :retweets_count, :integer, null: false, default: 0
  end
end
