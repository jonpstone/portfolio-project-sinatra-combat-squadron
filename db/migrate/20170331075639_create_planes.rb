class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :type
      t.integer :top_speed
      t.integer :ceiling
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
