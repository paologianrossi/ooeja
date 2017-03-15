class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :title
      t.text :notes

      t.timestamps
    end
    add_index :bookmarks, :url
    add_index :bookmarks, :notes
  end
end
