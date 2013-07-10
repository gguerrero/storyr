class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.date :published_on
      t.string :tags, array: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
