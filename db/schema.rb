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

ActiveRecord::Schema.define(version: 20150815064520) do

  create_table "article_managers", force: :cascade do |t|
    t.string   "keyword",       limit: 255
    t.integer  "article_index", limit: 4
    t.string   "page_url",      limit: 255
    t.integer  "article_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "article_type",  limit: 255
    t.integer  "community_id",  limit: 4
  end

  add_index "article_managers", ["article_id"], name: "index_article_managers_on_article_id", using: :btree
  add_index "article_managers", ["community_id"], name: "index_article_managers_on_community_id", using: :btree
  add_index "article_managers", ["keyword"], name: "index_article_managers_on_keyword", length: {"keyword"=>191}, using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.string   "author",          limit: 255
    t.text     "content",         limit: 65535
    t.string   "digest",          limit: 255
    t.string   "thumb_media_url", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

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
    t.integer  "code",       limit: 4,   null: false
  end

  add_index "communities", ["code"], name: "index_communities_on_code", using: :btree

  create_table "disaster_pictures", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "disaster_id",        limit: 4
  end

  add_index "disaster_pictures", ["disaster_id"], name: "index_disaster_pictures_on_disaster_id", using: :btree

  create_table "disaster_positions", force: :cascade do |t|
    t.float    "lon",        limit: 24
    t.float    "lat",        limit: 24
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "disasters", force: :cascade do |t|
    t.datetime "occur_time"
    t.string   "disaster_type",        limit: 255
    t.text     "explain",              limit: 65535
    t.integer  "subscriber_id",        limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "disaster_position_id", limit: 4
  end

  add_index "disasters", ["disaster_position_id"], name: "index_disasters_on_disaster_position_id", using: :btree
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
    t.string   "message_type",       limit: 255
  end

  add_index "message_processors", ["process_class_name"], name: "index_message_processors_on_process_class_name", length: {"process_class_name"=>191}, using: :btree

  create_table "monitor_stations", force: :cascade do |t|
    t.string   "station_number", limit: 255
    t.string   "station_name",   limit: 255
    t.string   "station_type",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "community_id",   limit: 4
  end

  add_index "monitor_stations", ["community_id"], name: "index_monitor_stations_on_community_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "option_title", limit: 255
    t.integer  "question_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "q_title",    limit: 255
    t.string   "q_type",     limit: 255
    t.string   "q_digest",   limit: 255
    t.integer  "survey_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "send_logs", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status",     limit: 255
    t.integer  "count",      limit: 4
    t.string   "explain",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "send_logs", ["start_time"], name: "index_send_logs_on_start_time", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "openid",       limit: 255
    t.integer  "sex",          limit: 4
    t.string   "city",         limit: 255
    t.string   "province",     limit: 255
    t.string   "country",      limit: 255
    t.string   "headimgurl",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "nick_name",    limit: 255
    t.integer  "community_id", limit: 4
  end

  add_index "subscribers", ["community_id"], name: "index_subscribers_on_community_id", using: :btree
  add_index "subscribers", ["openid"], name: "index_subscribers_on_openid", length: {"openid"=>191}, using: :btree

  create_table "survey_results", force: :cascade do |t|
    t.string   "q_result",      limit: 255
    t.integer  "survey_id",     limit: 4
    t.integer  "subscriber_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "survey_results", ["subscriber_id"], name: "index_survey_results_on_subscriber_id", using: :btree
  add_index "survey_results", ["survey_id"], name: "index_survey_results_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "s_title",      limit: 255
    t.string   "s_digest",     limit: 255
    t.string   "s_author",     limit: 255
    t.integer  "community_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "surveys", ["community_id"], name: "index_surveys_on_community_id", using: :btree

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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "subscriber_id", limit: 4
  end

  add_index "volunteers", ["subscriber_id"], name: "index_volunteers_on_subscriber_id", using: :btree
  add_index "volunteers", ["tel"], name: "index_volunteers_on_tel", length: {"tel"=>191}, using: :btree

  create_table "warnings", force: :cascade do |t|
    t.datetime "publish_time"
    t.string   "warning_type", limit: 255
    t.string   "level",        limit: 255
    t.text     "content",      limit: 65535
    t.integer  "community_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "status",       limit: 255
  end

  add_index "warnings", ["community_id"], name: "index_warnings_on_community_id", using: :btree
  add_index "warnings", ["publish_time"], name: "index_warnings_on_publish_time", using: :btree
  add_index "warnings", ["warning_type"], name: "index_warnings_on_warning_type", length: {"warning_type"=>191}, using: :btree

end
