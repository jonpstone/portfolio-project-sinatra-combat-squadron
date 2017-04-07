class CreatePlaneWeapons < ActiveRecord::Migration
  def change
    create_table :plane_weapons do |t|
      t.integer :plane_id
      t.integer :weapon_id
      t.timestamps null: false
    end
  end
end
