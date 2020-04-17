class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name, null: false
      t.string :description, null: false
    end

    add_index :groups, :name, unique: true
  end
end
