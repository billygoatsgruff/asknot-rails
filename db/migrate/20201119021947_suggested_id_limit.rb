class SuggestedIdLimit < ActiveRecord::Migration
  def change
    change_column :suggested_tweets, :twitter_id, :integer, limit: 8
  end
end
