class CreatePilots < ActiveRecord::Migration
  def change
    create_table :pilots do |t|
      t.string :username
      t.string :branch
      t.string :rank
      t.string :victories
      t.string :email
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
