class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
