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

ActiveRecord::Schema.define(version: 2018_12_26_233700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "converts", force: :cascade do |t|
    t.string "currency_from"
    t.string "currency_to"
    t.float "currency_give"
    t.float "currency_take"
    t.float "exchange_rates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
