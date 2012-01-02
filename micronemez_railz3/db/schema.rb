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

ActiveRecord::Schema.define(:version => 20120102075226) do

  create_table "kaltura_audios", :force => true do |t|
    t.string   "mediaId"
    t.string   "mediaType"
    t.string   "accessControlId"
    t.string   "adminTags"
    t.string   "categories"
    t.string   "categoriesIds"
    t.string   "conversionQuality"
    t.string   "createdAt"
    t.string   "creditUrl"
    t.string   "creditUserName"
    t.string   "dataUrl"
    t.string   "description"
    t.string   "downloadUrl"
    t.string   "duration"
    t.string   "durationType"
    t.string   "endDate"
    t.string   "flavorParamsIds"
    t.string   "groupId"
    t.string   "height"
    t.string   "licenseType"
    t.string   "mediaDate"
    t.string   "moderationCount"
    t.string   "moderationStatus"
    t.string   "msDuration"
    t.string   "name"
    t.string   "objectType"
    t.string   "partnerData"
    t.string   "partnerId"
    t.string   "plays"
    t.string   "rank"
    t.string   "searchProviderId"
    t.string   "searchProviderType"
    t.string   "searchText"
    t.string   "sourceType"
    t.string   "startDate"
    t.string   "status"
    t.string   "tags"
    t.string   "thumbnailUrl"
    t.string   "totalRank"
    t.string   "type"
    t.string   "updatedAt"
    t.string   "userId"
    t.string   "version"
    t.string   "views"
    t.string   "votes"
    t.string   "width"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kaltura_videos", :force => true do |t|
    t.string   "accessControlId"
    t.string   "adminTags"
    t.string   "categories"
    t.string   "categoriesIds"
    t.string   "conversionQuality"
    t.string   "createdAt"
    t.string   "creditUrl"
    t.string   "creditUserName"
    t.string   "dataUrl"
    t.string   "description"
    t.string   "downloadUrl"
    t.string   "duration"
    t.string   "durationType"
    t.string   "endDate"
    t.string   "flavorParamsIds"
    t.string   "groupId"
    t.string   "height"
    t.string   "licenseType"
    t.string   "mediaDate"
    t.string   "moderationCount"
    t.string   "moderationStatus"
    t.string   "msDuration"
    t.string   "name"
    t.string   "objectType"
    t.string   "partnerData"
    t.string   "partnerId"
    t.string   "plays"
    t.string   "rank"
    t.string   "searchProviderId"
    t.string   "searchProviderType"
    t.string   "searchText"
    t.string   "sourceType"
    t.string   "startDate"
    t.string   "status"
    t.string   "tags"
    t.string   "thumbnailUrl"
    t.string   "totalRank"
    t.string   "type"
    t.string   "updatedAt"
    t.string   "userId"
    t.string   "version"
    t.string   "views"
    t.string   "votes"
    t.string   "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_id"
    t.string   "mediaId"
    t.string   "mediaType"
  end

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "content"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
