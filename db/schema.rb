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

ActiveRecord::Schema.define(version: 20170823142158) do

  create_table "mentions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.string "slack_id", comment: "Mentioned user's slack user ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", comment: "Slack user name"
    t.string "profile_picture_url"
    t.index ["message_id"], name: "index_mentions_on_message_id"
  end

  create_table "message_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.bigint "mention_id"
    t.bigint "message_button_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mention_id"], name: "index_message_answers_on_mention_id"
    t.index ["message_button_id"], name: "index_message_answers_on_message_button_id"
    t.index ["message_id"], name: "index_message_answers_on_message_id"
  end

  create_table "message_buttons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.string "name", comment: "String to specify action"
    t.string "text", comment: "The user-facing label for the message button"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_buttons_on_message_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.text "message", comment: "Request message"
    t.datetime "due_at", comment: "Due to answer the request"
    t.boolean "require_confirm", default: false, comment: "Flag to use confirmation dialog"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "callback_id", comment: "Unique identifier for the Slack message button"
    t.integer "button_type"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "slack_id"
    t.string "name"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mentions", "messages"
  add_foreign_key "message_answers", "mentions"
  add_foreign_key "message_answers", "message_buttons"
  add_foreign_key "message_answers", "messages"
  add_foreign_key "message_buttons", "messages"
  add_foreign_key "messages", "users"
end
