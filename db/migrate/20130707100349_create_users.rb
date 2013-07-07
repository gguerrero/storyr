class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :fullname
      t.string  :encrypted_password
      t.string  :salt
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :name,  unique: true
    add_index :users, :email, unique: true
  end
end
