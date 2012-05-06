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

ActiveRecord::Schema.define(:version => 20120503230904) do

  create_table "comunidads", :force => true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "region"
    t.string   "pais"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relacionunidads", :force => true do |t|
    t.integer  "principal_id"
    t.integer  "vinculada_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "relacionunidads", ["principal_id", "vinculada_id"], :name => "index_relacionunidads_on_principal_id_and_vinculada_id", :unique => true
  add_index "relacionunidads", ["principal_id"], :name => "index_relacionunidads_on_principal_id"
  add_index "relacionunidads", ["vinculada_id"], :name => "index_relacionunidads_on_vinculada_id", :unique => true

  create_table "tipounidads", :force => true do |t|
    t.string   "nombre"
    t.integer  "comunidad_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "unidads", :force => true do |t|
    t.integer  "comunidad_id"
    t.integer  "tipounidad_id"
    t.string   "identificador"
    t.float    "participacion"
    t.float    "superficie"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.integer  "comunidad_id"
    t.string   "email"
    t.string   "nombre"
    t.boolean  "administrador"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
