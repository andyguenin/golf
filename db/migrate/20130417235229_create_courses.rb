class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :tournament_id
      t.string :name

      t.timestamps
    end
  end
end
