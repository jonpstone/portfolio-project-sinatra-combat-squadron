class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :type
      t.string :caliber
      t.timestamps null: false
    end
  end
end
