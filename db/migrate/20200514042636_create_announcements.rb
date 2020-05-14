class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements, id: :uuid do |t|
      t.string   :title, null: false
      t.text     :body,  null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
    end
  end
end
