class CreateSuggestedTweets < ActiveRecord::Migration
  def change
    create_table :suggested_tweets do |t|
      t.integer :twitter_id
      t.text :full_text

      t.timestamps null: false
    end
  end
end
