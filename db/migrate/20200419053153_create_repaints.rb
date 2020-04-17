class CreateRepaints < ActiveRecord::Migration[6.0]
  def change
    create_table :repaints, id: :uuid do |t|
      t.references :fleet, type: :uuid
      t.string :name, null: false
    end
  end
end
