# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_16_140121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "airlines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icao", null: false
    t.string "iata", null: false
    t.string "name", null: false
    t.index ["icao"], name: "index_airlines_on_icao", unique: true
  end

  create_table "airports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icao", limit: 4, null: false
    t.string "iata", limit: 3
    t.string "name"
    t.string "city"
    t.string "time_zone", default: "UTC", null: false
    t.decimal "latitude", precision: 8, scale: 5
    t.decimal "longitude", precision: 8, scale: 5
    t.index ["icao"], name: "index_airports_on_icao", unique: true
  end

  create_table "announcements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
  end

  create_table "equipment", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "short_name", null: false
    t.string "icao", limit: 4, null: false
    t.string "iata", limit: 3
    t.string "name", null: false
    t.text "description"
    t.index ["short_name"], name: "index_equipment_on_short_name", unique: true
  end

  create_table "fleets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id"
    t.uuid "equipment_id"
    t.index ["airline_id", "equipment_id"], name: "index_fleets_on_airline_id_and_equipment_id", unique: true
    t.index ["airline_id"], name: "index_fleets_on_airline_id"
    t.index ["equipment_id"], name: "index_fleets_on_equipment_id"
  end

  create_table "flights", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id", null: false
    t.uuid "equipment_id", null: false
    t.integer "number", limit: 2, null: false
    t.integer "leg", limit: 2, default: 1, null: false
    t.uuid "orig_id", null: false
    t.uuid "dest_id", null: false
    t.time "out_time", null: false
    t.time "in_time", null: false
    t.decimal "duration", precision: 3, scale: 1, null: false
    t.integer "distance", limit: 2, null: false
    t.string "slug", null: false
    t.index ["airline_id", "number", "leg"], name: "index_flights_on_airline_id_and_number_and_leg", unique: true
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["dest_id"], name: "index_flights_on_dest_id"
    t.index ["equipment_id"], name: "index_flights_on_equipment_id"
    t.index ["orig_id"], name: "index_flights_on_orig_id"
    t.index ["slug"], name: "index_flights_on_slug", unique: true
  end

  create_table "group_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.uuid "permission_id"
    t.index ["group_id"], name: "index_group_permissions_on_group_id"
    t.index ["permission_id"], name: "index_group_permissions_on_permission_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "networks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_networks_on_name", unique: true
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "pilot_id", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.boolean "read", default: false
    t.datetime "created_at"
    t.index ["pilot_id"], name: "index_notifications_on_pilot_id"
  end

  create_table "permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "model", null: false
    t.string "action", null: false
    t.string "description", null: false
    t.index ["model", "action"], name: "index_permissions_on_model_and_action", unique: true
  end

  create_table "pilots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "pid", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "group_id"
    t.boolean "active", default: false
    t.string "slug", null: false
    t.string "time_zone", default: "UTC", null: false
    t.index ["confirmation_token"], name: "index_pilots_on_confirmation_token", unique: true
    t.index ["email"], name: "index_pilots_on_email", unique: true
    t.index ["group_id"], name: "index_pilots_on_group_id"
    t.index ["pid"], name: "index_pilots_on_pid", unique: true
    t.index ["reset_password_token"], name: "index_pilots_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_pilots_on_slug", unique: true
    t.index ["unlock_token"], name: "index_pilots_on_unlock_token", unique: true
  end

  create_table "pirep_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "pirep_id", null: false
    t.uuid "author_id", null: false
    t.text "body", null: false
    t.datetime "created_at"
    t.index ["author_id"], name: "index_pirep_comments_on_author_id"
    t.index ["pirep_id"], name: "index_pirep_comments_on_pirep_id"
  end

  create_table "pirep_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 15, null: false
    t.boolean "editable", default: true
    t.boolean "approved", default: false
    t.boolean "pending", default: false
    t.string "color", limit: 7
    t.integer "sequence", limit: 2, null: false
    t.index ["name"], name: "index_pirep_statuses_on_name", unique: true
    t.index ["sequence"], name: "index_pirep_statuses_on_sequence", unique: true
  end

  create_table "pireps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "pilot_id", null: false
    t.date "date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "airline_id", null: false
    t.integer "flight", limit: 2, null: false
    t.integer "leg", limit: 2, null: false
    t.uuid "orig_id", null: false
    t.uuid "dest_id", null: false
    t.string "route", null: false
    t.uuid "equipment_id", null: false
    t.uuid "simulator_id", null: false
    t.decimal "duration", precision: 3, scale: 1, null: false
    t.integer "distance", limit: 2, null: false
    t.uuid "status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "network_id"
    t.index ["airline_id"], name: "index_pireps_on_airline_id"
    t.index ["dest_id"], name: "index_pireps_on_dest_id"
    t.index ["equipment_id"], name: "index_pireps_on_equipment_id"
    t.index ["orig_id"], name: "index_pireps_on_orig_id"
    t.index ["pilot_id"], name: "index_pireps_on_pilot_id"
    t.index ["simulator_id"], name: "index_pireps_on_simulator_id"
    t.index ["status_id"], name: "index_pireps_on_status_id"
  end

  create_table "repaints", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fleet_id"
    t.string "name", null: false
    t.index ["fleet_id"], name: "index_repaints_on_fleet_id"
  end

  create_table "settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "simulators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "short_name", limit: 15
    t.string "name"
    t.index ["name"], name: "index_simulators_on_name", unique: true
    t.index ["short_name"], name: "index_simulators_on_short_name", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.datetime "created_at"
    t.jsonb "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "airports", column: "dest_id"
  add_foreign_key "flights", "airports", column: "orig_id"
  add_foreign_key "flights", "equipment"
  add_foreign_key "group_permissions", "groups"
  add_foreign_key "group_permissions", "permissions"
  add_foreign_key "pilots", "groups"
  add_foreign_key "pirep_comments", "pilots", column: "author_id"
  add_foreign_key "pirep_comments", "pireps"
  add_foreign_key "pireps", "airlines"
  add_foreign_key "pireps", "airports", column: "dest_id"
  add_foreign_key "pireps", "airports", column: "orig_id"
  add_foreign_key "pireps", "equipment"
  add_foreign_key "pireps", "networks"
  add_foreign_key "pireps", "pilots"
  add_foreign_key "pireps", "pirep_statuses", column: "status_id"
  add_foreign_key "pireps", "simulators"
end
