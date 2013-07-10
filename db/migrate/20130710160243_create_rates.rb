class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :value
      t.text :comment
      t.references :story, index: true
      t.references :user, index: true
      t.date :rated_on

      t.timestamps
    end
  end
end
