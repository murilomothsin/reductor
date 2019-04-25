class CreateShorts < ActiveRecord::Migration[5.2]
  def change
    create_table :shorts do |t|
      t.string :url, null: false
      t.string :url_digest, null: false
      t.integer :click_count

      t.timestamps
    end
    add_index :shorts, :url_digest, unique: true
    add_index :shorts, :url, unique: true
  end
end
