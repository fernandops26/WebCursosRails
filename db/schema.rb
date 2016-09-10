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

ActiveRecord::Schema.define(version: 20160908204316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.boolean  "estado"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.boolean  "destacar"
  end

  create_table "contact_queries", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.string   "telefono"
    t.text     "mensaje"
    t.boolean  "leido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  add_index "courses", ["category_id"], name: "index_courses_on_category_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "nombredep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "nombredist"
    t.integer  "province_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "districts", ["province_id"], name: "index_districts_on_province_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.string   "razon"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  create_table "modalities", force: :cascade do |t|
    t.string   "nombremod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modalities_programations", id: false, force: :cascade do |t|
    t.integer "modality_id"
    t.integer "programation_id"
  end

  add_index "modalities_programations", ["modality_id"], name: "index_modalities_programations_on_modality_id", using: :btree
  add_index "modalities_programations", ["programation_id"], name: "index_modalities_programations_on_programation_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "nombres"
    t.string   "ape_pat"
    t.string   "ape_mat"
    t.boolean  "sexo"
    t.date     "f_nacimiento"
    t.integer  "celular"
    t.string   "email"
    t.integer  "district_id"
    t.string   "direccion"
    t.string   "profesion"
    t.string   "grado_acad"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "dni"
  end

  add_index "people", ["district_id"], name: "index_people_on_district_id", using: :btree

  create_table "programations", force: :cascade do |t|
    t.text     "descripcion"
    t.text     "objetivos"
    t.integer  "duracion"
    t.integer  "horas"
    t.decimal  "costo",          precision: 8, scale: 2
    t.text     "plan"
    t.integer  "institution_id"
    t.integer  "course_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "estado"
    t.date     "fecha"
  end

  add_index "programations", ["course_id"], name: "index_programations_on_course_id", using: :btree
  add_index "programations", ["institution_id"], name: "index_programations_on_institution_id", using: :btree

  create_table "provinces", force: :cascade do |t|
    t.string   "nombreprov"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "provinces", ["department_id"], name: "index_provinces_on_department_id", using: :btree

  create_table "subsidiaries", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "programation_id"
    t.boolean  "estado"
    t.boolean  "leido"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subsidiaries", ["person_id"], name: "index_subsidiaries_on_person_id", using: :btree
  add_index "subsidiaries", ["programation_id"], name: "index_subsidiaries_on_programation_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "type_user"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "courses", "categories"
  add_foreign_key "districts", "provinces"
  add_foreign_key "people", "districts"
  add_foreign_key "programations", "courses"
  add_foreign_key "programations", "institutions"
  add_foreign_key "provinces", "departments"
  add_foreign_key "subsidiaries", "people"
  add_foreign_key "subsidiaries", "programations"
end
