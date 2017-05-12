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

ActiveRecord::Schema.define(version: 20170512034436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["task_id"], name: "index_activities_on_task_id", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "appraisal_messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "appraisal_id"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["appraisal_id"], name: "index_appraisal_messages_on_appraisal_id", using: :btree
    t.index ["user_id"], name: "index_appraisal_messages_on_user_id", using: :btree
  end

  create_table "appraisal_prices", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "appraisal_id"
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["appraisal_id"], name: "index_appraisal_prices_on_appraisal_id", using: :btree
    t.index ["user_id"], name: "index_appraisal_prices_on_user_id", using: :btree
  end

  create_table "appraisals", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "appraisal_messages_count", default: 0
    t.integer  "appraisal_prices_count",   default: 0
    t.index ["category_id"], name: "index_appraisals_on_category_id", using: :btree
    t.index ["user_id"], name: "index_appraisals_on_user_id", using: :btree
  end

  create_table "cares", force: :cascade do |t|
    t.string   "careable_type"
    t.integer  "careable_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["careable_type", "careable_id"], name: "index_cares_on_careable_type_and_careable_id", using: :btree
    t.index ["user_id"], name: "index_cares_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "donate_infos", force: :cascade do |t|
    t.integer  "donate_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donates", force: :cascade do |t|
    t.integer  "work_id"
    t.decimal  "price"
    t.integer  "donor_id"
    t.integer  "bedonor_id"
    t.string   "aasm_state"
    t.string   "token"
    t.integer  "kind"
    t.boolean  "has_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aasm_state"], name: "index_donates_on_aasm_state", using: :btree
    t.index ["bedonor_id"], name: "index_donates_on_bedonor_id", using: :btree
    t.index ["donor_id"], name: "index_donates_on_donor_id", using: :btree
    t.index ["token"], name: "index_donates_on_token", using: :btree
    t.index ["work_id"], name: "index_donates_on_work_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "work_content"
    t.string   "work_area"
    t.text     "typical_work"
    t.integer  "teach"
    t.integer  "speak"
    t.integer  "labor"
    t.integer  "contract"
    t.integer  "category_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.text     "skill_tool"
    t.index ["category_id"], name: "index_user_infos_on_category_id", using: :btree
    t.index ["user_id"], name: "index_user_infos_on_user_id", using: :btree
  end

  create_table "user_surveys", force: :cascade do |t|
    t.text     "work_content"
    t.text     "work_area"
    t.text     "typical_work"
    t.string   "name"
    t.string   "email"
    t.text     "think"
    t.integer  "teach"
    t.integer  "speak"
    t.integer  "labor"
    t.integer  "contract"
    t.integer  "category_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "edited",       default: false
    t.index ["category_id"], name: "index_user_surveys_on_category_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "name"
    t.datetime "deleted_at"
    t.string   "remote_avatar_url"
    t.string   "fb_id"
    t.string   "slug"
    t.jsonb    "image_meta",             default: {},                    null: false
    t.string   "image"
    t.datetime "noticed_at",             default: '2017-05-12 03:48:49', null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  create_table "work_messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "work_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_messages_on_user_id", using: :btree
    t.index ["work_id"], name: "index_work_messages_on_work_id", using: :btree
  end

  create_table "works", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "slug"
    t.string   "attach_url"
    t.text     "attach_content"
    t.string   "attach_avatar"
    t.integer  "hits",                default: 0
    t.integer  "cares_count",         default: 0
    t.integer  "work_messages_count", default: 0
    t.string   "remote_image_url",    default: ""
    t.string   "remote_description",  default: ""
    t.jsonb    "image_meta",          default: {},    null: false
    t.boolean  "is_featured",         default: false
    t.boolean  "is_published",        default: false
    t.index ["is_featured"], name: "index_works_on_is_featured", using: :btree
    t.index ["is_published"], name: "index_works_on_is_published", using: :btree
    t.index ["slug"], name: "index_works_on_slug", unique: true, using: :btree
  end

end
