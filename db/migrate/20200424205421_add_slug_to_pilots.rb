class AddSlugToPilots < ActiveRecord::Migration[6.0]
  def change
    add_column :pilots, :slug, :string, null: false
    add_index :pilots, :slug, unique: true
  end
end
