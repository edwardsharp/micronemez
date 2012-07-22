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

ActiveRecord::Schema.define(:version => 20120404175258) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "kaltura_videos", :force => true do |t|
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
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "conversionProfileId"
    t.string   "operationAttributes"
    t.string   "partnerSortValue"
    t.string   "referenceId"
    t.string   "replacedEntryId"
    t.string   "replacementStatus"
    t.string   "replacingEntryId"
    t.string   "rootEntryId"
  end

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "content"
    t.text     "tags"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username"
    t.boolean  "agree"
    t.string   "name"
    t.string   "zip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "catnum"
    t.string   "title"
    t.string   "location"
    t.string   "description"
    t.string   "thumbnail_saveto"
    t.string   "thumbnail_url"
    t.string   "file_saveto"
    t.string   "file_pub_url"
    t.string   "file_cdn_url"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "keyword_id"
    t.integer  "sort"
    t.string   "kaltura_mediaId"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "video_upload_file_name"
    t.string   "video_upload_content_type"
    t.integer  "video_upload_file_size"
    t.datetime "video_upload_updated_at"
  end

  add_index "videos", ["catnum"], :name => "index_videos_on_catnum", :unique => true
  add_index "videos", ["kaltura_mediaId"], :name => "index_videos_on_kaltura_mediaId"
  add_index "videos", ["keyword_id"], :name => "index_videos_on_keyword_id"
  add_index "videos", ["sort"], :name => "index_videos_on_sort"
  add_index "videos", ["tag_id"], :name => "index_videos_on_tag_id"
  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"

end
