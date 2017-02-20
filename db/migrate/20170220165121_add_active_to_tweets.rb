class AddActiveToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :active, :boolean
  end
end
