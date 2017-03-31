class CreatePilotsPlanes < ActiveRecord::Migration
  def change
    create_table :pilots_planes do |t|
      t.integer :pilot_id
      t.integer :plane_id
      t.timestamps null: false
    end
  end
end
