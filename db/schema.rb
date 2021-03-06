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

ActiveRecord::Schema.define(version: 20140106190547) do

  create_table "messages", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twilio_sid"
    t.string   "status"
    t.datetime "date_sent"
  end

  create_table "text_messages", force: true do |t|
    t.string   "phone_number"
    t.string   "firstname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "text_messages", ["message_id"], name: "index_text_messages_on_message_id"

end
