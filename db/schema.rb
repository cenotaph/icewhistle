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

ActiveRecord::Schema.define(version: 2018_10_17_110644) do

  create_table "audiopodcasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.integer "item_id"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bytes"
    t.string "content_type"
    t.index ["item_type", "item_id"], name: "index_audiopodcasts_on_item_type_and_item_id"
  end

  create_table "blogimages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cached_feeds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uri", limit: 2048
    t.text "parsed_feed", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cashes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "source"
    t.string "title"
    t.string "link_url"
    t.text "content"
    t.integer "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_content_type"
    t.boolean "hidden", default: false, null: false
  end

  create_table "categories", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "link_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "imagefilename", limit: 50
  end

  create_table "ckeditor_assets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "comments", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "item_id"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "realname", limit: 100
    t.string "email", limit: 100
    t.string "item_type"
  end

  create_table "crumbles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.integer "category"
    t.string "icon"
    t.string "icon_content_type"
    t.integer "icon_file_size"
    t.datetime "icon_updated_at"
    t.string "attachment"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.date "datestamp"
    t.index ["slug"], name: "index_crumbles_on_slug", unique: true
  end

  create_table "friendly_id_slugs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "groupings", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "started"
    t.string "finished"
    t.string "employer"
    t.string "department"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "country"
    t.string "title"
    t.text "description"
    t.boolean "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.float "sortorder"
  end

  create_table "links", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.string "imagefilename", limit: 60
    t.integer "sortorder"
  end

  create_table "pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.text "body"
    t.boolean "published"
    t.string "image"
    t.string "image_content_type"
    t.integer "image_height"
    t.integer "image_width"
    t.integer "image_size"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "filename"
    t.integer "filename_width"
    t.integer "filename_height"
    t.string "filename_content_type"
    t.integer "filename_size"
    t.string "item_type"
    t.integer "item_id"
    t.string "title"
    t.text "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id"
  end

  create_table "posts", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grouping_id"
    t.text "extended"
    t.string "slug"
    t.string "enclosure_url"
    t.string "enclosure_type"
    t.bigint "enclosure_length"
    t.boolean "published", default: false
    t.string "image"
    t.integer "image_size"
    t.string "image_content_type"
    t.integer "image_width"
    t.integer "image_height"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "projects", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "projecttype", limit: 100
    t.string "url1"
    t.string "started"
    t.string "finished"
    t.string "url2"
    t.text "description"
    t.boolean "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "sortorder"
  end

  create_table "publications", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.string "format"
    t.string "publisher"
    t.string "date"
    t.text "description"
    t.boolean "major"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "realdate"
    t.string "icon"
    t.float "sortorder"
  end

  create_table "releases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.string "art1"
    t.string "art2"
    t.string "art3"
    t.string "art4"
    t.string "art5"
    t.date "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retrospections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ip_address"
    t.string "name"
    t.integer "age"
    t.integer "episodes_attended"
    t.integer "episodes_watched"
    t.integer "best_cast"
    t.string "best_guest"
    t.integer "nationality"
    t.integer "humour"
    t.integer "karaoke"
    t.integer "music"
    t.integer "introspection"
    t.integer "segment_1_culture"
    t.integer "segment_2_dance"
    t.integer "segment_3_distribution"
    t.integer "segment_4_mailbag"
    t.integer "segment_5_mjtrivia"
    t.integer "segment_6_showtell"
    t.integer "segment_7_siivous"
    t.integer "segment_8_trivia"
    t.integer "segment_9_visitortasks"
    t.integer "segment_10_justin"
    t.integer "segment_11_sigame"
    t.text "additional_comments"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "started", limit: 24
    t.string "finished", limit: 24
    t.string "name"
    t.string "degree"
    t.string "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "skilltype", limit: 50
  end

  create_table "songs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "lyrics"
    t.integer "track"
    t.string "mp3"
    t.integer "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.string "context"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "username", limit: 40
    t.string "name", limit: 100, default: ""
    t.string "email", limit: 100
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.string "confirmation_token"
    t.string "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "reset_password_token"
    t.datetime "remember_created_at"
    t.index ["username"], name: "index_users_on_login", unique: true
  end

  create_table "videos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.string "item_type"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bytes"
    t.string "content_type"
  end

end
