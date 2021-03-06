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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120420210008) do

  create_table "feed_entries", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_tag"
  end

  create_table "feed_entries_tags", :id => false, :force => true do |t|
    t.integer "feed_entry_id"
    t.integer "tag_id"
  end

  add_index "feed_entries_tags", ["feed_entry_id", "tag_id"], :name => "index_feed_entries_tags_on_feed_entry_id_and_tag_id"

  create_table "sources", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

end
