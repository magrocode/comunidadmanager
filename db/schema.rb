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

ActiveRecord::Schema.define(:version => 20120524132452) do

  create_table "comunidads", :force => true do |t|
    t.string   "nombre"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
    t.string   "twitter"
    t.string   "telefono"
  end

  create_table "relacion_unidads", :force => true do |t|
    t.integer  "principal_id"
    t.integer  "vinculada_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "relacion_unidads", ["principal_id", "vinculada_id"], :name => "index_relacion_unidads_on_principal_id_and_vinculada_id", :unique => true
  add_index "relacion_unidads", ["principal_id"], :name => "index_relacion_unidads_on_principal_id"
  add_index "relacion_unidads", ["vinculada_id"], :name => "index_relacion_unidads_on_vinculada_id", :unique => true

  create_table "relacion_usuario_unidads", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "unidad_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "relacion_usuario_unidads", ["unidad_id"], :name => "index_relacion_usuario_unidads_on_unidad_id"
  add_index "relacion_usuario_unidads", ["usuario_id", "unidad_id"], :name => "index_relacion_usuario_unidads_on_usuario_id_and_unidad_id", :unique => true
  add_index "relacion_usuario_unidads", ["usuario_id"], :name => "index_relacion_usuario_unidads_on_usuario_id"

  create_table "tipounidads", :force => true do |t|
    t.string   "nombre"
    t.integer  "comunidad_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tipounidads", ["comunidad_id"], :name => "index_tipounidads_on_comunidad_id"

  create_table "unidads", :force => true do |t|
    t.integer  "comunidad_id"
    t.integer  "tipounidad_id"
    t.string   "identificador"
    t.float    "participacion"
    t.float    "superficie"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "unidads", ["comunidad_id"], :name => "index_unidads_on_comunidad_id"
  add_index "unidads", ["identificador"], :name => "index_unidads_on_identificador"

  create_table "usuarios", :force => true do |t|
    t.integer  "comunidad_id"
    t.string   "email"
    t.string   "nombre"
    t.boolean  "administrador"
    t.boolean  "system_admin"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "twitter"
    t.string   "telefono"
  end

  add_index "usuarios", ["comunidad_id"], :name => "index_usuarios_on_comunidad_id"
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email"
  add_index "usuarios", ["remember_token"], :name => "index_usuarios_on_remember_token"

end
