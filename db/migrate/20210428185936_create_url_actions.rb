class CreateUrlActions < ActiveRecord::Migration
  def change
    create_table :url_actions do |t|
      t.text :url
      t.string :title
      t.string :subtitle
      t.string :prompt
      t.string :action_title
      t.text :action_text
      t.string :button_text
      t.boolean :active

      t.timestamps null: false
    end
  end
end
