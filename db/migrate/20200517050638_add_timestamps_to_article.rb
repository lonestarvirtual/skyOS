class AddTimestampsToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
    add_reference :articles, :author, type: :uuid
    add_reference :articles, :editor, type: :uuid
  end
end
