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

ActiveRecord::Schema.define(version: 20170325174637) do

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

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "work_content"
    t.text     "work_area"
    t.text     "typical_work"
    t.integer  "teach"
    t.integer  "speak"
    t.integer  "labor"
    t.integer  "contract"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.text     "skill_and_tool"
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
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
