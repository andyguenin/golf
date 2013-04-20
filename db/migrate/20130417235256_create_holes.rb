class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :course_id
      t.integer :hole_number
      t.integer :parr

      t.timestamps
    end
  end
end
