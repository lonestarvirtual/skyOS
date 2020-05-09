class CreatePirepComments < ActiveRecord::Migration[6.0]
  def change
    create_table :pirep_comments, id: :uuid do |t|
      t.references :pirep, type: :uuid, index: true, null: false, foreign_key: true
      t.references :author, type: :uuid, index: true, null: false, foreign_key: {to_table: :pilots}
      t.text :body, null: false
      t.datetime :created_at
    end
  end
end
