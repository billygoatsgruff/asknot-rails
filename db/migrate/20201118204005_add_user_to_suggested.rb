class AddUserToSuggested < ActiveRecord::Migration
  def change
    add_reference :suggested_tweets, :user, foreign_key: true
  end
end
