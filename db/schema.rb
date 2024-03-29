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

ActiveRecord::Schema.define(:version => 20120407001348) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "line_items", :force => true do |t|
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity",   :default => 1
    t.integer  "order_id"
  end

  create_table "orders", :force => true do |t|
    t.string   "payment_type"
    t.string   "pay_status"
    t.decimal  "total_price"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",         :precision => 8, :scale => 2
    t.string   "platform"
    t.string   "genre"
    t.string   "publisher"
    t.string   "developer"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "image_url"
    t.string   "released_date"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "username"
    t.string   "auth_token"
    t.boolean  "active",               :default => false
    t.string   "activation_token"
    t.string   "password_reset_token"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "admin",                :default => false
  end

end
