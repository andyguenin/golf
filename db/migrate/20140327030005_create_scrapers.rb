class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :label
      t.string :url
      t.string :post_to
      t.integer :frequency
      t.datetime :starttime
      t.datetime :endtime
      t.integer :user_id
      t.boolean :pause

      t.timestamps
    end
  end
end
