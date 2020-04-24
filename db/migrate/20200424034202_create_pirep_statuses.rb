class CreatePirepStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :pirep_statuses, id: :uuid do |t|
      t.string :name, null: false, limit: 15
      t.boolean :editable, default: true
      t.boolean :approved, default: false
      t.boolean :pending, default: false
      t.string :color, limit: 7
      t.integer :sequence, limit: 1, null: false
    end

    add_index :pirep_statuses, :name, unique: true
    add_index :pirep_statuses, :sequence, unique: true
  end
end

#
# Draft:     editable: true,  approved: false, pending: false   TFF
# Submitted: editable: false, approved: false, pending: true    FFT
# Held:      editable: false, approved: false, pending: false   FFF
# Approved:  editable: false, approved: true,  pending: false   FTF
# Rejected:  editable: false, approved: false, pending: false   FFF
#