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

ActiveRecord::Schema.define(version: 20151011114660) do

  create_table "blogimages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "filename",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cached_feeds", force: :cascade do |t|
    t.string   "uri",         limit: 2048
    t.text     "parsed_feed", limit: 16777215
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cashes", force: :cascade do |t|
    t.string   "source",             limit: 255
    t.string   "title",              limit: 255
    t.string   "link_url",           limit: 255
    t.text     "content",            limit: 65535
    t.integer  "order",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",              limit: 255
    t.integer  "image_size",         limit: 4
    t.integer  "image_width",        limit: 4
    t.integer  "image_height",       limit: 4
    t.string   "image_content_type", limit: 255
    t.boolean  "hidden",                           default: false, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "link_id",       limit: 4
    t.string   "name",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagefilename", limit: 50
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "realname",   limit: 100
    t.string   "email",      limit: 100
    t.string   "item_type",  limit: 255
  end

  create_table "crumbles", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.integer  "category",                limit: 4
    t.string   "icon",                    limit: 255
    t.string   "icon_content_type",       limit: 255
    t.integer  "icon_file_size",          limit: 4
    t.datetime "icon_updated_at"
    t.string   "attachment",              limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
    t.text     "description",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                    limit: 255
    t.date     "datestamp"
  end

  add_index "crumbles", ["slug"], name: "index_crumbles_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groupings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "started",     limit: 255
    t.string   "finished",    limit: 255
    t.string   "employer",    limit: 255
    t.string   "department",  limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.string   "postcode",    limit: 255
    t.string   "country",     limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.float    "sortorder",   limit: 24
  end

  create_table "links", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.string   "url",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",   limit: 4
    t.string   "imagefilename", limit: 60
    t.integer  "sortorder",     limit: 4
  end

  create_table "photos", force: :cascade do |t|
    t.string   "filename",              limit: 255
    t.integer  "filename_width",        limit: 4
    t.integer  "filename_height",       limit: 4
    t.string   "filename_content_type", limit: 255
    t.integer  "filename_size",         limit: 4
    t.string   "item_type",             limit: 255
    t.integer  "item_id",               limit: 4
    t.string   "title",                 limit: 255
    t.text     "caption",               limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "body",               limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grouping_id",        limit: 4
    t.text     "extended",           limit: 65535
    t.string   "slug",               limit: 255
    t.string   "enclosure_url",      limit: 255
    t.string   "enclosure_type",     limit: 255
    t.integer  "enclosure_length",   limit: 8
    t.boolean  "published",                        default: false
    t.string   "image",              limit: 255
    t.integer  "image_size",         limit: 4
    t.string   "image_content_type", limit: 255
    t.integer  "image_width",        limit: 4
    t.integer  "image_height",       limit: 4
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "projecttype", limit: 100
    t.string   "url1",        limit: 255
    t.string   "started",     limit: 255
    t.string   "finished",    limit: 255
    t.string   "url2",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sortorder",   limit: 24
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "format",      limit: 255
    t.string   "publisher",   limit: 255
    t.string   "date",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.string   "icon",        limit: 255
    t.float    "sortorder",   limit: 24
  end

  create_table "releases", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "art1",         limit: 255
    t.string   "art2",         limit: 255
    t.string   "art3",         limit: 255
    t.string   "art4",         limit: 255
    t.string   "art5",         limit: 255
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "started",    limit: 24
    t.string   "finished",   limit: 24
    t.string   "name",       limit: 255
    t.string   "degree",     limit: 255
    t.string   "subject",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: :cascade do |t|
    t.text     "skills",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "skilltype",  limit: 50
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.text     "lyrics",      limit: 65535
    t.integer  "track",       limit: 4
    t.string   "mp3",         limit: 255
    t.integer  "release_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4,   null: false
    t.integer  "taggable_id",   limit: 4,   null: false
    t.string   "taggable_type", limit: 255, null: false
    t.string   "context",       limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                  limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "encrypted_password",        limit: 128, default: "", null: false
    t.string   "password_salt",             limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token",        limit: 255
    t.string   "confirmed_at",              limit: 255
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token",      limit: 255
    t.datetime "remember_created_at"
  end

  add_index "users", ["username"], name: "index_users_on_login", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.string   "item_type",  limit: 255
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
