class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :name
      t.string :manufacturer
      t.string :top_speed
      t.string :ceiling
      t.string :type
      t.timestamps null: false
    end
  end
end
