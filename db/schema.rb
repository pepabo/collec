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

ActiveRecord::Schema.define(version: 20170807141535) do

  create_table "mentioned_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.integer "user_id", comment: "メンションされたユーザーのSlackユーザーID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_mentioned_users_on_message_id"
  end

  create_table "message_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.bigint "mentioned_user_id"
    t.bigint "message_button_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentioned_user_id"], name: "index_message_answers_on_mentioned_user_id"
    t.index ["message_button_id"], name: "index_message_answers_on_message_button_id"
    t.index ["message_id"], name: "index_message_answers_on_message_id"
  end

  create_table "message_buttons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "message_id"
    t.string "name", comment: "ユーザーが入力したボタン名"
    t.string "value", comment: "ユーザーが選択したアクションを識別するための文字列"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_buttons_on_message_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "slack_user_id"
    t.text "message", comment: "依頼文"
    t.datetime "dut_at", comment: "対応期限日"
    t.boolean "require_confirm", default: false, comment: "確認用ポップアップフラグ 0: 無し 1: 有り"
    t.integer "remind_interval", comment: "リマインド間隔"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slack_user_id"], name: "index_messages_on_slack_user_id"
  end

  create_table "slack_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "user_id", comment: "SlackのユーザーID"
    t.string "access_token", comment: "Slack APIのアクセストークン"
    t.string "name", comment: "Slackのユーザー名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mentioned_users", "messages"
  add_foreign_key "message_answers", "mentioned_users"
  add_foreign_key "message_answers", "message_buttons"
  add_foreign_key "message_answers", "messages"
  add_foreign_key "message_buttons", "messages"
  add_foreign_key "messages", "slack_users"
end
