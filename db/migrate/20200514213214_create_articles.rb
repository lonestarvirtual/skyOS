class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :slug
      t.string :title, null: false
      t.boolean :private, null: false, default: true
      t.boolean :published, null: false, default: false
    end

    add_index :articles, :slug, unique: true
  end
end
