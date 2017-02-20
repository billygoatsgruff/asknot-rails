class AddWhyToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :why, :text
  end
end
