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

ActiveRecord::Schema.define(version: 2021_04_01_145254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "conversation_messages", force: :cascade do |t|
    t.boolean "is_deleted"
    t.text "content"
    t.bigint "conversation_id"
    t.bigint "sender_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listing_categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 50
    t.bigint "parent_category_id"
    t.index ["parent_category_id"], name: "index_listing_categories_on_parent_category_id"
  end

  create_table "listing_conditions", force: :cascade do |t|
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listing_deliveries", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "delivery_id"
    t.bigint "listing_id"
    t.index ["delivery_id"], name: "index_listing_deliveries_on_delivery_id"
    t.index ["listing_id"], name: "index_listing_deliveries_on_listing_id"
  end

  create_table "listing_questions", force: :cascade do |t|
    t.string "question", limit: 50
    t.string "answer", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id"
    t.index ["listing_id"], name: "index_listing_questions_on_listing_id"
  end

  create_table "listing_ratings", force: :cascade do |t|
    t.integer "seller_rating"
    t.integer "buyer_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id"
    t.index ["listing_id"], name: "index_listing_ratings_on_listing_id"
  end

  create_table "listing_statuses", force: :cascade do |t|
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listing_tags", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id"
    t.bigint "tag_id"
    t.index ["listing_id"], name: "index_listing_tags_on_listing_id"
    t.index ["tag_id"], name: "index_listing_tags_on_tag_id"
  end

  create_table "listing_views", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id"
    t.bigint "user_id"
    t.index ["listing_id"], name: "index_listing_views_on_listing_id"
    t.index ["user_id"], name: "index_listing_views_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.boolean "is_active"
    t.boolean "is_moderated"
    t.string "title", limit: 50
    t.text "description"
    t.decimal "price"
    t.decimal "discounted_price"
    t.string "location", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "swap"
    t.bigint "listing_category_id"
    t.bigint "creator_id"
    t.bigint "moderator_id"
    t.bigint "receiver_id"
    t.bigint "listing_condition_id"
    t.bigint "listing_status_id"
    t.index ["creator_id"], name: "index_listings_on_creator_id"
    t.index ["listing_category_id"], name: "index_listings_on_listing_category_id"
    t.index ["listing_condition_id"], name: "index_listings_on_listing_condition_id"
    t.index ["listing_status_id"], name: "index_listings_on_listing_status_id"
    t.index ["moderator_id"], name: "index_listings_on_moderator_id"
    t.index ["receiver_id"], name: "index_listings_on_receiver_id"
  end

  create_table "listings_delivery", force: :cascade do |t|
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "page_contents", force: :cascade do |t|
    t.string "key", limit: 50
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.text "message"
    t.text "outcome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "conversation_message_id"
    t.bigint "listing_id"
    t.bigint "moderator_id"
    t.bigint "reporter_id"
    t.index ["conversation_message_id"], name: "index_reports_on_conversation_message_id"
    t.index ["listing_id"], name: "index_reports_on_listing_id"
    t.index ["moderator_id"], name: "index_reports_on_moderator_id"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "key", limit: 50
    t.string "value"
    t.text "blocked_words"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_favourites", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listing_id"
    t.bigint "user_id"
    t.index ["listing_id"], name: "index_user_favourites_on_listing_id"
    t.index ["user_id"], name: "index_user_favourites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.boolean "administrator"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "listing_categories", "listing_categories", column: "parent_category_id"
  add_foreign_key "listing_deliveries", "deliveries"
  add_foreign_key "listing_deliveries", "listings"
  add_foreign_key "listing_questions", "listings"
  add_foreign_key "listing_ratings", "listings"
  add_foreign_key "listing_tags", "listings"
  add_foreign_key "listing_tags", "tags"
  add_foreign_key "listing_views", "listings"
  add_foreign_key "listing_views", "users"
  add_foreign_key "listings", "listing_categories"
  add_foreign_key "listings", "listing_conditions"
  add_foreign_key "listings", "listing_statuses"
  add_foreign_key "listings", "users", column: "creator_id"
  add_foreign_key "listings", "users", column: "moderator_id"
  add_foreign_key "listings", "users", column: "receiver_id"
  add_foreign_key "reports", "conversation_messages"
  add_foreign_key "reports", "listings"
  add_foreign_key "reports", "users", column: "moderator_id"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "user_favourites", "listings"
  add_foreign_key "user_favourites", "users"
end
