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

ActiveRecord::Schema.define(version: 20140825082741) do

  create_table "blogimages", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cached_feeds", force: true do |t|
    t.string   "uri",         limit: 2048
    t.text     "parsed_feed", limit: 16777215
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cashes", force: true do |t|
    t.string   "source"
    t.string   "title"
    t.string   "link_url"
    t.text     "content"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.boolean  "hidden",             default: false, null: false
  end

  create_table "categories", force: true do |t|
    t.integer  "link_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagefilename", limit: 50
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "item_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "realname",   limit: 100
    t.string   "email",      limit: 100
    t.string   "item_type"
  end

  create_table "crumbles", force: true do |t|
    t.string   "title"
    t.integer  "category"
    t.string   "icon"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "attachment"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.date     "datestamp"
  end

  add_index "crumbles", ["slug"], name: "index_crumbles_on_slug", unique: true, using: :btree

  create_table "groupings", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "started"
    t.string   "finished"
    t.string   "employer"
    t.string   "department"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postcode"
    t.string   "country"
    t.string   "title"
    t.text     "description"
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.float    "sortorder"
  end

  create_table "links", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "imagefilename", limit: 60
    t.integer  "sortorder"
  end

  create_table "photos", force: true do |t|
    t.string   "filename"
    t.integer  "filename_width"
    t.integer  "filename_height"
    t.string   "filename_content_type"
    t.integer  "filename_size"
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "title"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grouping_id"
    t.text     "extended"
    t.string   "slug"
    t.string   "enclosure_url"
    t.string   "enclosure_type"
    t.integer  "enclosure_length",   limit: 8
    t.boolean  "published",                    default: false
    t.string   "image"
    t.integer  "image_size"
    t.string   "image_content_type"
    t.integer  "image_width"
    t.integer  "image_height"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "projecttype", limit: 100
    t.string   "url1"
    t.string   "started"
    t.string   "finished"
    t.string   "url2"
    t.text     "description"
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sortorder"
  end

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "format"
    t.string   "publisher"
    t.string   "date"
    t.text     "description"
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.string   "icon"
    t.float    "sortorder"
  end

  create_table "releases", force: true do |t|
    t.string   "title"
    t.string   "art1"
    t.string   "art2"
    t.string   "art3"
    t.string   "art4"
    t.string   "art5"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "started",    limit: 24
    t.string   "finished",   limit: 24
    t.string   "name"
    t.string   "degree"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.text     "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "skilltype",  limit: 50
  end

  create_table "songs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "lyrics"
    t.integer  "track"
    t.string   "mp3"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id",        null: false
    t.integer  "taggable_id",   null: false
    t.string   "taggable_type", null: false
    t.string   "context"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                  limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "encrypted_password",        limit: 128, default: "", null: false
    t.string   "password_salt",                         default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token"
    t.string   "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
  end

  add_index "users", ["username"], name: "index_users_on_login", unique: true, using: :btree

end
