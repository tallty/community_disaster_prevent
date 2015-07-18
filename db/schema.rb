# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150701095107) do

  create_table "articles", force: :cascade do |t|
    t.string   "event_key",          limit: 255
    t.string   "title",              limit: 255
    t.string   "author",             limit: 255
    t.string   "content_source_url", limit: 255
    t.text     "content",            limit: 65535
    t.string   "digest",             limit: 255
    t.integer  "show_cover_pic",     limit: 4
    t.string   "article_type",       limit: 255
    t.string   "is_show",            limit: 255
    t.string   "thumb_media_url",    limit: 255
    t.string   "keywords",           limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "articles", ["article_type"], name: "index_articles_on_article_type", length: {"article_type"=>191}, using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", length: {"title"=>191}, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "district",   limit: 255
    t.string   "street",     limit: 255
    t.string   "c_type",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "disaster_pictures", force: :cascade do |t|
    t.string   "file_name",         limit: 255
    t.string   "url",               limit: 255
    t.string   "local_path",        limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "data_file_name",    limit: 255
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.datetime "data_updated_at"
  end

  create_table "disaster_positions", force: :cascade do |t|
    t.float    "lon",        limit: 24
    t.float    "lat",        limit: 24
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "disasters", force: :cascade do |t|
    t.datetime "occur_time"
    t.string   "disaster_type",         limit: 255
    t.text     "explain",               limit: 65535
    t.integer  "subscriber_id",         limit: 4
    t.integer  "disaster_positions_id", limit: 4
    t.integer  "disaster_picture_id",   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "disasters", ["disaster_picture_id"], name: "index_disasters_on_disaster_picture_id", using: :btree
  add_index "disasters", ["disaster_positions_id"], name: "index_disasters_on_disaster_positions_id", using: :btree
  add_index "disasters", ["occur_time"], name: "index_disasters_on_occur_time", using: :btree
  add_index "disasters", ["subscriber_id"], name: "index_disasters_on_subscriber_id", using: :btree

  create_table "diymenus", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.string   "url",        limit: 255
    t.boolean  "is_show",    limit: 1
    t.integer  "sort",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "diymenus", ["key"], name: "index_diymenus_on_key", length: {"key"=>191}, using: :btree
  add_index "diymenus", ["parent_id"], name: "index_diymenus_on_parent_id", using: :btree

  create_table "message_processors", force: :cascade do |t|
    t.string   "event_key",          limit: 255
    t.string   "process_class_name", limit: 255
    t.string   "process_method",     limit: 255
    t.string   "result_type",        limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "message_processors", ["process_class_name"], name: "index_message_processors_on_process_class_name", length: {"process_class_name"=>191}, using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "openid",     limit: 255
    t.integer  "sex",        limit: 4
    t.string   "city",       limit: 255
    t.string   "province",   limit: 255
    t.string   "country",    limit: 255
    t.string   "headimgurl", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "nick_name",  limit: 255
  end

  add_index "subscribers", ["openid"], name: "index_subscribers_on_openid", length: {"openid"=>191}, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 64,  default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 128
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "tel",           limit: 255
    t.string   "commun",        limit: 255
    t.string   "neighborhood",  limit: 255
    t.integer  "subscriber_id", limit: 4
    t.integer  "communitie_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "volunteers", ["communitie_id"], name: "index_volunteers_on_communitie_id", using: :btree
  add_index "volunteers", ["subscriber_id"], name: "index_volunteers_on_subscriber_id", using: :btree
  add_index "volunteers", ["tel"], name: "index_volunteers_on_tel", length: {"tel"=>191}, using: :btree

end
