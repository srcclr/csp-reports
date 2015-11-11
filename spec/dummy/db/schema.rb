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

ActiveRecord::Schema.define(version: 20151111102249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"

  create_table "api_keys", force: :cascade do |t|
    t.string   "key",           limit: 64,                 null: false
    t.integer  "user_id"
    t.integer  "created_by_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.inet     "allowed_ips",                                           array: true
    t.boolean  "hidden",                   default: false, null: false
  end

  add_index "api_keys", ["key"], name: "index_api_keys_on_key", using: :btree
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", unique: true, using: :btree

  create_table "application_requests", force: :cascade do |t|
    t.date    "date",                 null: false
    t.integer "req_type",             null: false
    t.integer "count",    default: 0, null: false
  end

  add_index "application_requests", ["date", "req_type"], name: "index_application_requests_on_date_and_req_type", unique: true, using: :btree

  create_table "badge_groupings", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "position",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "badge_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "badge_types", ["name"], name: "index_badge_types_on_name", unique: true, using: :btree

  create_table "badges", force: :cascade do |t|
    t.string   "name",                                                     null: false
    t.text     "description"
    t.integer  "badge_type_id",                                            null: false
    t.integer  "grant_count",                   default: 0,                null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.boolean  "allow_title",                   default: false,            null: false
    t.boolean  "multiple_grant",                default: false,            null: false
    t.string   "icon",                          default: "fa-certificate"
    t.boolean  "listable",                      default: true
    t.boolean  "target_posts",                  default: false
    t.text     "query"
    t.boolean  "enabled",                       default: true,             null: false
    t.boolean  "auto_revoke",                   default: true,             null: false
    t.integer  "badge_grouping_id",             default: 5,                null: false
    t.integer  "trigger"
    t.boolean  "show_posts",                    default: false,            null: false
    t.boolean  "system",                        default: false,            null: false
    t.string   "image",             limit: 255
    t.text     "long_description"
  end

  add_index "badges", ["badge_type_id"], name: "index_badges_on_badge_type_id", using: :btree
  add_index "badges", ["name"], name: "index_badges_on_name", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",                          limit: 50,                    null: false
    t.string   "color",                         limit: 6,  default: "AB9364", null: false
    t.integer  "topic_id"
    t.integer  "topic_count",                              default: 0,        null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "user_id",                                                     null: false
    t.integer  "topics_year",                              default: 0
    t.integer  "topics_month",                             default: 0
    t.integer  "topics_week",                              default: 0
    t.string   "slug",                                                        null: false
    t.text     "description"
    t.string   "text_color",                    limit: 6,  default: "FFFFFF", null: false
    t.boolean  "read_restricted",                          default: false,    null: false
    t.float    "auto_close_hours"
    t.integer  "post_count",                               default: 0,        null: false
    t.integer  "latest_post_id"
    t.integer  "latest_topic_id"
    t.integer  "position"
    t.integer  "parent_category_id"
    t.integer  "posts_year",                               default: 0
    t.integer  "posts_month",                              default: 0
    t.integer  "posts_week",                               default: 0
    t.string   "email_in"
    t.boolean  "email_in_allow_strangers",                 default: false
    t.integer  "topics_day",                               default: 0
    t.integer  "posts_day",                                default: 0
    t.string   "logo_url"
    t.string   "background_url"
    t.boolean  "allow_badges",                             default: true,     null: false
    t.string   "name_lower",                    limit: 50,                    null: false
    t.boolean  "auto_close_based_on_last_post",            default: false
    t.text     "topic_template"
    t.boolean  "suppress_from_homepage",                   default: false
  end

  add_index "categories", ["email_in"], name: "index_categories_on_email_in", unique: true, using: :btree
  add_index "categories", ["name"], name: "unique_index_categories_on_name", unique: true, using: :btree
  add_index "categories", ["topic_count"], name: "index_categories_on_topic_count", using: :btree

  create_table "category_custom_fields", force: :cascade do |t|
    t.integer  "category_id",             null: false
    t.string   "name",        limit: 256, null: false
    t.text     "value"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "category_custom_fields", ["category_id", "name"], name: "index_category_custom_fields_on_category_id_and_name", using: :btree

  create_table "category_featured_topics", force: :cascade do |t|
    t.integer  "category_id",             null: false
    t.integer  "topic_id",                null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "rank",        default: 0, null: false
  end

  add_index "category_featured_topics", ["category_id", "rank"], name: "index_category_featured_topics_on_category_id_and_rank", using: :btree
  add_index "category_featured_topics", ["category_id", "topic_id"], name: "cat_featured_threads", unique: true, using: :btree

  create_table "category_featured_users", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "category_featured_users", ["category_id", "user_id"], name: "index_category_featured_users_on_category_id_and_user_id", unique: true, using: :btree

  create_table "category_groups", force: :cascade do |t|
    t.integer  "category_id",                 null: false
    t.integer  "group_id",                    null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "permission_type", default: 1
  end

  create_table "category_search_data", primary_key: "category_id", force: :cascade do |t|
    t.tsvector "search_data"
    t.text     "raw_data"
    t.text     "locale"
  end

  add_index "category_search_data", ["search_data"], name: "idx_search_category", using: :gin

  create_table "category_users", force: :cascade do |t|
    t.integer "category_id",        null: false
    t.integer "user_id",            null: false
    t.integer "notification_level", null: false
  end

  create_table "color_scheme_colors", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "hex",             null: false
    t.integer  "color_scheme_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "color_scheme_colors", ["color_scheme_id"], name: "index_color_scheme_colors_on_color_scheme_id", using: :btree

  create_table "color_schemes", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "enabled",      default: false, null: false
    t.integer  "versioned_id"
    t.integer  "version",      default: 1,     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "csp_reports_domains", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "csp_reports_domains", ["user_id"], name: "index_csp_reports_domains_on_user_id", using: :btree

  create_table "csp_reports_reports", force: :cascade do |t|
    t.hstore   "result",                default: {}, null: false
    t.integer  "csp_reports_domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "csp_reports_reports", ["csp_reports_domain_id"], name: "index_csp_reports_reports_on_csp_reports_domain_id", using: :btree

  create_table "csp_reports_viewers", force: :cascade do |t|
    t.integer "csp_reports_domains_id"
    t.integer "user_id"
  end

  add_index "csp_reports_viewers", ["csp_reports_domains_id"], name: "index_csp_reports_viewers_on_csp_reports_domains_id", using: :btree
  add_index "csp_reports_viewers", ["user_id"], name: "index_csp_reports_viewers_on_user_id", using: :btree

  create_table "digest_unsubscribe_keys", primary_key: "key", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "digest_unsubscribe_keys", ["created_at"], name: "index_digest_unsubscribe_keys_on_created_at", using: :btree

  create_table "directory_items", force: :cascade do |t|
    t.integer  "period_type",                null: false
    t.integer  "user_id",                    null: false
    t.integer  "likes_received",             null: false
    t.integer  "likes_given",                null: false
    t.integer  "topics_entered",             null: false
    t.integer  "topic_count",                null: false
    t.integer  "post_count",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_visited",   default: 0, null: false
    t.integer  "posts_read",     default: 0, null: false
  end

  add_index "directory_items", ["period_type"], name: "index_directory_items_on_period_type", using: :btree

  create_table "discourse_reports_chapters", force: :cascade do |t|
    t.string  "name",                      default: "", null: false
    t.string  "slug",                      default: "", null: false
    t.integer "discourse_reports_part_id"
    t.integer "position",                  default: 0,  null: false
  end

  add_index "discourse_reports_chapters", ["discourse_reports_part_id"], name: "index_discourse_reports_chapters_on_discourse_reports_part_id", using: :btree
  add_index "discourse_reports_chapters", ["position"], name: "index_discourse_reports_chapters_on_position", using: :btree

  create_table "discourse_reports_parts", force: :cascade do |t|
    t.string  "name",        default: "", null: false
    t.string  "slug",        default: "", null: false
    t.integer "position",    default: 0,  null: false
    t.text    "description", default: "", null: false
  end

  add_index "discourse_reports_parts", ["position"], name: "index_discourse_reports_parts_on_position", using: :btree

  create_table "draft_sequences", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.string  "draft_key", null: false
    t.integer "sequence",  null: false
  end

  add_index "draft_sequences", ["user_id", "draft_key"], name: "index_draft_sequences_on_user_id_and_draft_key", unique: true, using: :btree

  create_table "drafts", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "draft_key",              null: false
    t.text     "data",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "sequence",   default: 0, null: false
    t.integer  "revisions",  default: 1, null: false
  end

  add_index "drafts", ["user_id", "draft_key"], name: "index_drafts_on_user_id_and_draft_key", using: :btree

  create_table "email_logs", force: :cascade do |t|
    t.string   "to_address",                                null: false
    t.string   "email_type",                                null: false
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "reply_key",      limit: 32
    t.integer  "post_id"
    t.integer  "topic_id"
    t.boolean  "skipped",                   default: false
    t.string   "skipped_reason"
  end

  add_index "email_logs", ["created_at"], name: "index_email_logs_on_created_at", order: {"created_at"=>:desc}, using: :btree
  add_index "email_logs", ["reply_key"], name: "index_email_logs_on_reply_key", using: :btree
  add_index "email_logs", ["skipped", "created_at"], name: "index_email_logs_on_skipped_and_created_at", using: :btree
  add_index "email_logs", ["user_id", "created_at"], name: "index_email_logs_on_user_id_and_created_at", order: {"created_at"=>:desc}, using: :btree

  create_table "email_tokens", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "email",                      null: false
    t.string   "token",                      null: false
    t.boolean  "confirmed",  default: false, null: false
    t.boolean  "expired",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "email_tokens", ["token"], name: "index_email_tokens_on_token", unique: true, using: :btree
  add_index "email_tokens", ["user_id"], name: "index_email_tokens_on_user_id", using: :btree

  create_table "embeddable_hosts", force: :cascade do |t|
    t.string   "host",        null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_user_infos", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "facebook_user_id", limit: 8, null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "facebook_user_infos", ["facebook_user_id"], name: "index_facebook_user_infos_on_facebook_user_id", unique: true, using: :btree
  add_index "facebook_user_infos", ["user_id"], name: "index_facebook_user_infos_on_user_id", unique: true, using: :btree

  create_table "github_user_infos", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.string   "screen_name",    null: false
    t.integer  "github_user_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "github_user_infos", ["github_user_id"], name: "index_github_user_infos_on_github_user_id", unique: true, using: :btree
  add_index "github_user_infos", ["user_id"], name: "index_github_user_infos_on_user_id", unique: true, using: :btree

  create_table "google_user_infos", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.string   "google_user_id", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "name"
    t.string   "link"
    t.string   "profile_link"
    t.string   "picture"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "google_user_infos", ["google_user_id"], name: "index_google_user_infos_on_google_user_id", unique: true, using: :btree
  add_index "google_user_infos", ["user_id"], name: "index_google_user_infos_on_user_id", unique: true, using: :btree

  create_table "group_custom_fields", force: :cascade do |t|
    t.integer  "group_id",               null: false
    t.string   "name",       limit: 256, null: false
    t.text     "value"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "group_custom_fields", ["group_id", "name"], name: "index_group_custom_fields_on_group_id_and_name", using: :btree

  create_table "group_managers", force: :cascade do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_managers", ["group_id", "user_id"], name: "index_group_managers_on_group_id_and_user_id", unique: true, using: :btree

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_users", ["group_id", "user_id"], name: "index_group_users_on_group_id_and_user_id", unique: true, using: :btree
  add_index "group_users", ["user_id", "group_id"], name: "index_group_users_on_user_id_and_group_id", unique: true, using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",                                               null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "automatic",                          default: false, null: false
    t.integer  "user_count",                         default: 0,     null: false
    t.integer  "alias_level",                        default: 0
    t.boolean  "visible",                            default: true,  null: false
    t.text     "automatic_membership_email_domains"
    t.boolean  "automatic_membership_retroactive",   default: false
    t.boolean  "primary_group",                      default: false, null: false
    t.string   "title"
    t.integer  "grant_trust_level"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "headlines_categories", force: :cascade do |t|
    t.string   "title",       default: "",                    null: false
    t.string   "topic",       default: "",                    null: false
    t.datetime "created_at",  default: '2015-08-26 14:06:29', null: false
    t.datetime "updated_at",  default: '2015-08-26 14:06:29', null: false
    t.integer  "category_id"
    t.text     "description", default: ""
    t.integer  "parents",     default: [],                    null: false, array: true
  end

  add_index "headlines_categories", ["category_id"], name: "index_headlines_categories_on_category_id", using: :btree
  add_index "headlines_categories", ["parents"], name: "index_headlines_categories_on_parents", using: :gin

  create_table "headlines_domains", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.integer  "rank",                default: 0,  null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "country_code",        default: "", null: false
    t.xml      "data_alexa"
    t.integer  "parent_category_ids", default: [], null: false, array: true
    t.integer  "last_scan_id"
  end

  add_index "headlines_domains", ["last_scan_id"], name: "index_headlines_domains_on_last_scan_id", using: :btree
  add_index "headlines_domains", ["name"], name: "index_headlines_domains_on_name", unique: true, using: :btree
  add_index "headlines_domains", ["parent_category_ids"], name: "index_headlines_domains_on_parent_category_ids", using: :gin

  create_table "headlines_domains_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.datetime "created_at",  default: '2015-08-26 14:06:29', null: false
    t.datetime "updated_at",  default: '2015-08-26 14:06:29', null: false
    t.string   "domain_name"
  end

  add_index "headlines_domains_categories", ["category_id"], name: "index_headlines_domains_categories_on_category_id", using: :btree
  add_index "headlines_domains_categories", ["domain_name"], name: "index_headlines_domains_categories_on_domain_name", using: :btree

  create_table "headlines_scans", force: :cascade do |t|
    t.json     "headers",    default: {}, null: false
    t.hstore   "results",    default: {}, null: false
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",      default: 0
    t.integer  "http_score", default: 0
    t.integer  "csp_score",  default: 0
  end

  add_index "headlines_scans", ["domain_id"], name: "index_headlines_scans_on_domain_id", using: :btree
  add_index "headlines_scans", ["score"], name: "index_headlines_scans_on_score", using: :btree

  create_table "incoming_domains", force: :cascade do |t|
    t.string  "name",  limit: 100,                 null: false
    t.boolean "https",             default: false, null: false
    t.integer "port",                              null: false
  end

  add_index "incoming_domains", ["name", "https", "port"], name: "index_incoming_domains_on_name_and_https_and_port", unique: true, using: :btree

  create_table "incoming_links", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.integer  "user_id"
    t.inet     "ip_address"
    t.integer  "current_user_id"
    t.integer  "post_id",             null: false
    t.integer  "incoming_referer_id"
  end

  add_index "incoming_links", ["created_at", "user_id"], name: "index_incoming_links_on_created_at_and_user_id", using: :btree
  add_index "incoming_links", ["post_id"], name: "index_incoming_links_on_post_id", using: :btree

  create_table "incoming_referers", force: :cascade do |t|
    t.string  "path",               limit: 1000, null: false
    t.integer "incoming_domain_id",              null: false
  end

  add_index "incoming_referers", ["path", "incoming_domain_id"], name: "index_incoming_referers_on_path_and_incoming_domain_id", unique: true, using: :btree

  create_table "invited_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "invite_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "invite_key",     limit: 32, null: false
    t.string   "email"
    t.integer  "invited_by_id",             null: false
    t.integer  "user_id"
    t.datetime "redeemed_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.integer  "deleted_by_id"
    t.datetime "invalidated_at"
  end

  add_index "invites", ["email", "invited_by_id"], name: "index_invites_on_email_and_invited_by_id", using: :btree
  add_index "invites", ["invite_key"], name: "index_invites_on_invite_key", unique: true, using: :btree

  create_table "message_bus", force: :cascade do |t|
    t.string   "name"
    t.string   "context"
    t.text     "data"
    t.datetime "created_at", null: false
  end

  add_index "message_bus", ["created_at"], name: "index_message_bus_on_created_at", using: :btree

  create_table "muted_users", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "muted_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "muted_users", ["muted_user_id", "user_id"], name: "index_muted_users_on_muted_user_id_and_user_id", unique: true, using: :btree
  add_index "muted_users", ["user_id", "muted_user_id"], name: "index_muted_users_on_user_id_and_muted_user_id", unique: true, using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "notification_type",                              null: false
    t.integer  "user_id",                                        null: false
    t.string   "data",              limit: 1000,                 null: false
    t.boolean  "read",                           default: false, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "topic_id"
    t.integer  "post_number"
    t.integer  "post_action_id"
  end

  add_index "notifications", ["post_action_id"], name: "index_notifications_on_post_action_id", using: :btree
  add_index "notifications", ["user_id", "created_at"], name: "index_notifications_on_user_id_and_created_at", using: :btree
  add_index "notifications", ["user_id", "notification_type"], name: "idx_notifications_speedup_unread_count", where: "(NOT read)", using: :btree
  add_index "notifications", ["user_id", "topic_id", "post_number"], name: "index_notifications_on_user_id_and_topic_id_and_post_number", using: :btree

  create_table "oauth2_user_infos", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "oauth2_user_infos", ["uid", "provider"], name: "index_oauth2_user_infos_on_uid_and_provider", unique: true, using: :btree

  create_table "optimized_images", force: :cascade do |t|
    t.string  "sha1",      limit: 40, null: false
    t.string  "extension", limit: 10, null: false
    t.integer "width",                null: false
    t.integer "height",               null: false
    t.integer "upload_id",            null: false
    t.string  "url",                  null: false
  end

  add_index "optimized_images", ["upload_id", "width", "height"], name: "index_optimized_images_on_upload_id_and_width_and_height", unique: true, using: :btree
  add_index "optimized_images", ["upload_id"], name: "index_optimized_images_on_upload_id", using: :btree

  create_table "permalinks", force: :cascade do |t|
    t.string   "url",          limit: 1000, null: false
    t.integer  "topic_id"
    t.integer  "post_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_url", limit: 1000
  end

  add_index "permalinks", ["url"], name: "index_permalinks_on_url", unique: true, using: :btree

  create_table "plugin_store_rows", force: :cascade do |t|
    t.string "plugin_name", null: false
    t.string "key",         null: false
    t.string "type_name",   null: false
    t.text   "value"
  end

  add_index "plugin_store_rows", ["plugin_name", "key"], name: "index_plugin_store_rows_on_plugin_name_and_key", unique: true, using: :btree

  create_table "post_action_types", force: :cascade do |t|
    t.string   "name_key",   limit: 50,                 null: false
    t.boolean  "is_flag",               default: false, null: false
    t.string   "icon",       limit: 20
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "position",              default: 0,     null: false
  end

  create_table "post_actions", force: :cascade do |t|
    t.integer  "post_id",                             null: false
    t.integer  "user_id",                             null: false
    t.integer  "post_action_type_id",                 null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "deleted_by_id"
    t.integer  "related_post_id"
    t.boolean  "staff_took_action",   default: false, null: false
    t.integer  "deferred_by_id"
    t.boolean  "targets_topic",       default: false, null: false
    t.datetime "agreed_at"
    t.integer  "agreed_by_id"
    t.datetime "deferred_at"
    t.datetime "disagreed_at"
    t.integer  "disagreed_by_id"
  end

  add_index "post_actions", ["post_id"], name: "index_post_actions_on_post_id", using: :btree
  add_index "post_actions", ["user_id", "post_action_type_id", "post_id", "targets_topic"], name: "idx_unique_actions", unique: true, where: "(((deleted_at IS NULL) AND (disagreed_at IS NULL)) AND (deferred_at IS NULL))", using: :btree
  add_index "post_actions", ["user_id", "post_action_type_id"], name: "index_post_actions_on_user_id_and_post_action_type_id", where: "(deleted_at IS NULL)", using: :btree
  add_index "post_actions", ["user_id", "post_id", "targets_topic"], name: "idx_unique_flags", unique: true, where: "((((deleted_at IS NULL) AND (disagreed_at IS NULL)) AND (deferred_at IS NULL)) AND (post_action_type_id = ANY (ARRAY[3, 4, 7, 8])))", using: :btree

  create_table "post_custom_fields", force: :cascade do |t|
    t.integer  "post_id",                null: false
    t.string   "name",       limit: 256, null: false
    t.text     "value"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "post_custom_fields", ["name"], name: "index_post_custom_fields_on_name_and_value", using: :btree
  add_index "post_custom_fields", ["post_id", "name"], name: "index_post_custom_fields_on_post_id_and_name", using: :btree

  create_table "post_details", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "key"
    t.string   "value"
    t.text     "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_details", ["post_id", "key"], name: "index_post_details_on_post_id_and_key", unique: true, using: :btree

  create_table "post_replies", id: false, force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "reply_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_replies", ["post_id", "reply_id"], name: "index_post_replies_on_post_id_and_reply_id", unique: true, using: :btree

  create_table "post_revisions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "modifications"
    t.integer  "number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "hidden",        default: false, null: false
  end

  add_index "post_revisions", ["post_id", "number"], name: "index_post_revisions_on_post_id_and_number", using: :btree
  add_index "post_revisions", ["post_id"], name: "index_post_revisions_on_post_id", using: :btree

  create_table "post_search_data", primary_key: "post_id", force: :cascade do |t|
    t.tsvector "search_data"
    t.text     "raw_data"
    t.string   "locale"
  end

  add_index "post_search_data", ["search_data"], name: "idx_search_post", using: :gin

  create_table "post_stats", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "drafts_saved"
    t.integer  "typing_duration_msecs"
    t.integer  "composer_open_duration_msecs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_stats", ["post_id"], name: "index_post_stats_on_post_id", using: :btree

  create_table "post_timings", id: false, force: :cascade do |t|
    t.integer "topic_id",    null: false
    t.integer "post_number", null: false
    t.integer "user_id",     null: false
    t.integer "msecs",       null: false
  end

  add_index "post_timings", ["topic_id", "post_number", "user_id"], name: "post_timings_unique", unique: true, using: :btree
  add_index "post_timings", ["topic_id", "post_number"], name: "post_timings_summary", using: :btree
  add_index "post_timings", ["user_id"], name: "index_post_timings_on_user_id", using: :btree

  create_table "post_uploads", force: :cascade do |t|
    t.integer "post_id",   null: false
    t.integer "upload_id", null: false
  end

  add_index "post_uploads", ["post_id", "upload_id"], name: "idx_unique_post_uploads", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id",                                null: false
    t.integer  "post_number",                             null: false
    t.text     "raw",                                     null: false
    t.text     "cooked",                                  null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "reply_to_post_number"
    t.integer  "reply_count",             default: 0,     null: false
    t.integer  "quote_count",             default: 0,     null: false
    t.datetime "deleted_at"
    t.integer  "off_topic_count",         default: 0,     null: false
    t.integer  "like_count",              default: 0,     null: false
    t.integer  "incoming_link_count",     default: 0,     null: false
    t.integer  "bookmark_count",          default: 0,     null: false
    t.integer  "avg_time"
    t.float    "score"
    t.integer  "reads",                   default: 0,     null: false
    t.integer  "post_type",               default: 1,     null: false
    t.integer  "vote_count",              default: 0,     null: false
    t.integer  "sort_order"
    t.integer  "last_editor_id"
    t.boolean  "hidden",                  default: false, null: false
    t.integer  "hidden_reason_id"
    t.integer  "notify_moderators_count", default: 0,     null: false
    t.integer  "spam_count",              default: 0,     null: false
    t.integer  "illegal_count",           default: 0,     null: false
    t.integer  "inappropriate_count",     default: 0,     null: false
    t.datetime "last_version_at",                         null: false
    t.boolean  "user_deleted",            default: false, null: false
    t.integer  "reply_to_user_id"
    t.float    "percent_rank",            default: 1.0
    t.integer  "notify_user_count",       default: 0,     null: false
    t.integer  "like_score",              default: 0,     null: false
    t.integer  "deleted_by_id"
    t.string   "edit_reason"
    t.integer  "word_count"
    t.integer  "version",                 default: 1,     null: false
    t.integer  "cook_method",             default: 1,     null: false
    t.boolean  "wiki",                    default: false, null: false
    t.datetime "baked_at"
    t.integer  "baked_version"
    t.datetime "hidden_at"
    t.integer  "self_edits",              default: 0,     null: false
    t.boolean  "reply_quoted",            default: false, null: false
    t.boolean  "via_email",               default: false, null: false
    t.text     "raw_email"
    t.integer  "public_version",          default: 1,     null: false
    t.string   "action_code"
  end

  add_index "posts", ["created_at", "topic_id"], name: "idx_posts_created_at_topic_id", where: "(deleted_at IS NULL)", using: :btree
  add_index "posts", ["reply_to_post_number"], name: "index_posts_on_reply_to_post_number", using: :btree
  add_index "posts", ["topic_id", "post_number"], name: "index_posts_on_topic_id_and_post_number", unique: true, using: :btree
  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree
  add_index "posts", ["user_id"], name: "idx_posts_user_id_deleted_at", where: "(deleted_at IS NULL)", using: :btree

  create_table "queued_posts", force: :cascade do |t|
    t.string   "queue",          null: false
    t.integer  "state",          null: false
    t.integer  "user_id",        null: false
    t.text     "raw",            null: false
    t.json     "post_options",   null: false
    t.integer  "topic_id"
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.integer  "rejected_by_id"
    t.datetime "rejected_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queued_posts", ["queue", "state", "created_at"], name: "by_queue_status", using: :btree
  add_index "queued_posts", ["topic_id", "queue", "state", "created_at"], name: "by_queue_status_topic", using: :btree

  create_table "quoted_posts", force: :cascade do |t|
    t.integer  "post_id",        null: false
    t.integer  "quoted_post_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "quoted_posts", ["post_id", "quoted_post_id"], name: "index_quoted_posts_on_post_id_and_quoted_post_id", unique: true, using: :btree
  add_index "quoted_posts", ["quoted_post_id", "post_id"], name: "index_quoted_posts_on_quoted_post_id_and_post_id", unique: true, using: :btree

  create_table "screened_emails", force: :cascade do |t|
    t.string   "email",                     null: false
    t.integer  "action_type",               null: false
    t.integer  "match_count",   default: 0, null: false
    t.datetime "last_match_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.inet     "ip_address"
  end

  add_index "screened_emails", ["email"], name: "index_screened_emails_on_email", unique: true, using: :btree
  add_index "screened_emails", ["last_match_at"], name: "index_screened_emails_on_last_match_at", using: :btree

  create_table "screened_ip_addresses", force: :cascade do |t|
    t.inet     "ip_address",                null: false
    t.integer  "action_type",               null: false
    t.integer  "match_count",   default: 0, null: false
    t.datetime "last_match_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "screened_ip_addresses", ["ip_address"], name: "index_screened_ip_addresses_on_ip_address", unique: true, using: :btree
  add_index "screened_ip_addresses", ["last_match_at"], name: "index_screened_ip_addresses_on_last_match_at", using: :btree

  create_table "screened_urls", force: :cascade do |t|
    t.string   "url",                       null: false
    t.string   "domain",                    null: false
    t.integer  "action_type",               null: false
    t.integer  "match_count",   default: 0, null: false
    t.datetime "last_match_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.inet     "ip_address"
  end

  add_index "screened_urls", ["last_match_at"], name: "index_screened_urls_on_last_match_at", using: :btree
  add_index "screened_urls", ["url"], name: "index_screened_urls_on_url", unique: true, using: :btree

  create_table "single_sign_on_records", force: :cascade do |t|
    t.integer  "user_id",             null: false
    t.string   "external_id",         null: false
    t.text     "last_payload",        null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "external_username"
    t.string   "external_email"
    t.string   "external_name"
    t.string   "external_avatar_url"
  end

  add_index "single_sign_on_records", ["external_id"], name: "index_single_sign_on_records_on_external_id", unique: true, using: :btree

  create_table "site_customizations", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.text     "stylesheet"
    t.text     "header"
    t.integer  "user_id",                              null: false
    t.boolean  "enabled",                              null: false
    t.string   "key",                                  null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "stylesheet_baked",        default: "", null: false
    t.text     "mobile_stylesheet"
    t.text     "mobile_header"
    t.text     "mobile_stylesheet_baked"
    t.text     "footer"
    t.text     "mobile_footer"
    t.text     "head_tag"
    t.text     "body_tag"
    t.text     "top"
    t.text     "mobile_top"
    t.text     "embedded_css"
    t.text     "embedded_css_baked"
  end

  add_index "site_customizations", ["key"], name: "index_site_customizations_on_key", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "data_type",  null: false
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_texts", id: false, force: :cascade do |t|
    t.string   "text_type",  null: false
    t.text     "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "site_texts", ["text_type"], name: "index_site_texts_on_text_type", unique: true, using: :btree

  create_table "stylesheet_cache", force: :cascade do |t|
    t.string   "target",     null: false
    t.string   "digest",     null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stylesheet_cache", ["target", "digest"], name: "index_stylesheet_cache_on_target_and_digest", unique: true, using: :btree

  create_table "top_topics", force: :cascade do |t|
    t.integer "topic_id"
    t.integer "yearly_posts_count",       default: 0,   null: false
    t.integer "yearly_views_count",       default: 0,   null: false
    t.integer "yearly_likes_count",       default: 0,   null: false
    t.integer "monthly_posts_count",      default: 0,   null: false
    t.integer "monthly_views_count",      default: 0,   null: false
    t.integer "monthly_likes_count",      default: 0,   null: false
    t.integer "weekly_posts_count",       default: 0,   null: false
    t.integer "weekly_views_count",       default: 0,   null: false
    t.integer "weekly_likes_count",       default: 0,   null: false
    t.integer "daily_posts_count",        default: 0,   null: false
    t.integer "daily_views_count",        default: 0,   null: false
    t.integer "daily_likes_count",        default: 0,   null: false
    t.float   "daily_score",              default: 0.0
    t.float   "weekly_score",             default: 0.0
    t.float   "monthly_score",            default: 0.0
    t.float   "yearly_score",             default: 0.0
    t.float   "all_score",                default: 0.0
    t.integer "daily_op_likes_count",     default: 0,   null: false
    t.integer "weekly_op_likes_count",    default: 0,   null: false
    t.integer "monthly_op_likes_count",   default: 0,   null: false
    t.integer "yearly_op_likes_count",    default: 0,   null: false
    t.integer "quarterly_posts_count",    default: 0,   null: false
    t.integer "quarterly_views_count",    default: 0,   null: false
    t.integer "quarterly_likes_count",    default: 0,   null: false
    t.float   "quarterly_score",          default: 0.0
    t.integer "quarterly_op_likes_count", default: 0,   null: false
  end

  add_index "top_topics", ["daily_likes_count"], name: "index_top_topics_on_daily_likes_count", order: {"daily_likes_count"=>:desc}, using: :btree
  add_index "top_topics", ["daily_op_likes_count"], name: "index_top_topics_on_daily_op_likes_count", using: :btree
  add_index "top_topics", ["daily_posts_count"], name: "index_top_topics_on_daily_posts_count", order: {"daily_posts_count"=>:desc}, using: :btree
  add_index "top_topics", ["daily_views_count"], name: "index_top_topics_on_daily_views_count", order: {"daily_views_count"=>:desc}, using: :btree
  add_index "top_topics", ["monthly_likes_count"], name: "index_top_topics_on_monthly_likes_count", order: {"monthly_likes_count"=>:desc}, using: :btree
  add_index "top_topics", ["monthly_op_likes_count"], name: "index_top_topics_on_monthly_op_likes_count", using: :btree
  add_index "top_topics", ["monthly_posts_count"], name: "index_top_topics_on_monthly_posts_count", order: {"monthly_posts_count"=>:desc}, using: :btree
  add_index "top_topics", ["monthly_views_count"], name: "index_top_topics_on_monthly_views_count", order: {"monthly_views_count"=>:desc}, using: :btree
  add_index "top_topics", ["quarterly_likes_count"], name: "index_top_topics_on_quarterly_likes_count", using: :btree
  add_index "top_topics", ["quarterly_op_likes_count"], name: "index_top_topics_on_quarterly_op_likes_count", using: :btree
  add_index "top_topics", ["quarterly_posts_count"], name: "index_top_topics_on_quarterly_posts_count", using: :btree
  add_index "top_topics", ["quarterly_views_count"], name: "index_top_topics_on_quarterly_views_count", using: :btree
  add_index "top_topics", ["topic_id"], name: "index_top_topics_on_topic_id", unique: true, using: :btree
  add_index "top_topics", ["weekly_likes_count"], name: "index_top_topics_on_weekly_likes_count", order: {"weekly_likes_count"=>:desc}, using: :btree
  add_index "top_topics", ["weekly_op_likes_count"], name: "index_top_topics_on_weekly_op_likes_count", using: :btree
  add_index "top_topics", ["weekly_posts_count"], name: "index_top_topics_on_weekly_posts_count", order: {"weekly_posts_count"=>:desc}, using: :btree
  add_index "top_topics", ["weekly_views_count"], name: "index_top_topics_on_weekly_views_count", order: {"weekly_views_count"=>:desc}, using: :btree
  add_index "top_topics", ["yearly_likes_count"], name: "index_top_topics_on_yearly_likes_count", order: {"yearly_likes_count"=>:desc}, using: :btree
  add_index "top_topics", ["yearly_op_likes_count"], name: "index_top_topics_on_yearly_op_likes_count", using: :btree
  add_index "top_topics", ["yearly_posts_count"], name: "index_top_topics_on_yearly_posts_count", order: {"yearly_posts_count"=>:desc}, using: :btree
  add_index "top_topics", ["yearly_views_count"], name: "index_top_topics_on_yearly_views_count", order: {"yearly_views_count"=>:desc}, using: :btree

  create_table "topic_allowed_groups", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "topic_id", null: false
  end

  add_index "topic_allowed_groups", ["group_id", "topic_id"], name: "index_topic_allowed_groups_on_group_id_and_topic_id", unique: true, using: :btree
  add_index "topic_allowed_groups", ["topic_id", "group_id"], name: "index_topic_allowed_groups_on_topic_id_and_group_id", unique: true, using: :btree

  create_table "topic_allowed_users", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topic_allowed_users", ["topic_id", "user_id"], name: "index_topic_allowed_users_on_topic_id_and_user_id", unique: true, using: :btree
  add_index "topic_allowed_users", ["user_id", "topic_id"], name: "index_topic_allowed_users_on_user_id_and_topic_id", unique: true, using: :btree

  create_table "topic_custom_fields", force: :cascade do |t|
    t.integer  "topic_id",               null: false
    t.string   "name",       limit: 256, null: false
    t.text     "value"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "topic_custom_fields", ["topic_id", "name"], name: "index_topic_custom_fields_on_topic_id_and_name", using: :btree
  add_index "topic_custom_fields", ["value"], name: "index_topic_custom_fields_on_value", using: :btree

  create_table "topic_embeds", force: :cascade do |t|
    t.integer  "topic_id",                  null: false
    t.integer  "post_id",                   null: false
    t.string   "embed_url",    limit: 1000, null: false
    t.string   "content_sha1", limit: 40
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "topic_embeds", ["embed_url"], name: "index_topic_embeds_on_embed_url", unique: true, using: :btree

  create_table "topic_invites", force: :cascade do |t|
    t.integer  "topic_id",   null: false
    t.integer  "invite_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topic_invites", ["invite_id"], name: "index_topic_invites_on_invite_id", using: :btree
  add_index "topic_invites", ["topic_id", "invite_id"], name: "index_topic_invites_on_topic_id_and_invite_id", unique: true, using: :btree

  create_table "topic_link_clicks", force: :cascade do |t|
    t.integer  "topic_link_id", null: false
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.inet     "ip_address",    null: false
  end

  add_index "topic_link_clicks", ["topic_link_id"], name: "by_link", using: :btree

  create_table "topic_links", force: :cascade do |t|
    t.integer  "topic_id",                                  null: false
    t.integer  "post_id"
    t.integer  "user_id",                                   null: false
    t.string   "url",           limit: 500,                 null: false
    t.string   "domain",        limit: 100,                 null: false
    t.boolean  "internal",                  default: false, null: false
    t.integer  "link_topic_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "reflection",                default: false
    t.integer  "clicks",                    default: 0,     null: false
    t.integer  "link_post_id"
    t.string   "title"
    t.datetime "crawled_at"
    t.boolean  "quote",                     default: false, null: false
  end

  add_index "topic_links", ["link_post_id", "reflection"], name: "index_topic_links_on_link_post_id_and_reflection", using: :btree
  add_index "topic_links", ["post_id"], name: "index_topic_links_on_post_id", using: :btree
  add_index "topic_links", ["topic_id", "post_id", "url"], name: "unique_post_links", unique: true, using: :btree
  add_index "topic_links", ["topic_id"], name: "index_topic_links_on_topic_id", using: :btree

  create_table "topic_search_data", primary_key: "topic_id", force: :cascade do |t|
    t.text     "raw_data"
    t.string   "locale",      null: false
    t.tsvector "search_data"
  end

  add_index "topic_search_data", ["search_data"], name: "idx_search_topic", using: :gin

  create_table "topic_users", force: :cascade do |t|
    t.integer  "user_id",                                  null: false
    t.integer  "topic_id",                                 null: false
    t.boolean  "posted",                   default: false, null: false
    t.integer  "last_read_post_number"
    t.integer  "highest_seen_post_number"
    t.datetime "last_visited_at"
    t.datetime "first_visited_at"
    t.integer  "notification_level",       default: 1,     null: false
    t.datetime "notifications_changed_at"
    t.integer  "notifications_reason_id"
    t.integer  "total_msecs_viewed",       default: 0,     null: false
    t.datetime "cleared_pinned_at"
    t.integer  "last_emailed_post_number"
    t.boolean  "liked",                    default: false
    t.boolean  "bookmarked",               default: false
  end

  add_index "topic_users", ["topic_id", "user_id"], name: "index_topic_users_on_topic_id_and_user_id", unique: true, using: :btree
  add_index "topic_users", ["user_id", "topic_id"], name: "index_topic_users_on_user_id_and_topic_id", unique: true, using: :btree

  create_table "topic_views", id: false, force: :cascade do |t|
    t.integer "topic_id",   null: false
    t.date    "viewed_at",  null: false
    t.integer "user_id"
    t.inet    "ip_address", null: false
  end

  add_index "topic_views", ["ip_address", "topic_id"], name: "ip_address_topic_id_topic_views", unique: true, where: "(user_id IS NULL)", using: :btree
  add_index "topic_views", ["topic_id", "viewed_at"], name: "index_topic_views_on_topic_id_and_viewed_at", using: :btree
  add_index "topic_views", ["user_id", "topic_id"], name: "user_id_topic_id_topic_views", unique: true, where: "(user_id IS NOT NULL)", using: :btree
  add_index "topic_views", ["viewed_at", "topic_id"], name: "index_topic_views_on_viewed_at_and_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",                                                          null: false
    t.datetime "last_posted_at"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "views",                                      default: 0,         null: false
    t.integer  "posts_count",                                default: 0,         null: false
    t.integer  "user_id"
    t.integer  "last_post_user_id",                                              null: false
    t.integer  "reply_count",                                default: 0,         null: false
    t.integer  "featured_user1_id"
    t.integer  "featured_user2_id"
    t.integer  "featured_user3_id"
    t.integer  "avg_time"
    t.datetime "deleted_at"
    t.integer  "highest_post_number",                        default: 0,         null: false
    t.string   "image_url"
    t.integer  "off_topic_count",                            default: 0,         null: false
    t.integer  "like_count",                                 default: 0,         null: false
    t.integer  "incoming_link_count",                        default: 0,         null: false
    t.integer  "bookmark_count",                             default: 0,         null: false
    t.integer  "category_id"
    t.boolean  "visible",                                    default: true,      null: false
    t.integer  "moderator_posts_count",                      default: 0,         null: false
    t.boolean  "closed",                                     default: false,     null: false
    t.boolean  "archived",                                   default: false,     null: false
    t.datetime "bumped_at",                                                      null: false
    t.boolean  "has_summary",                                default: false,     null: false
    t.integer  "vote_count",                                 default: 0,         null: false
    t.string   "archetype",                                  default: "regular", null: false
    t.integer  "featured_user4_id"
    t.integer  "notify_moderators_count",                    default: 0,         null: false
    t.integer  "spam_count",                                 default: 0,         null: false
    t.integer  "illegal_count",                              default: 0,         null: false
    t.integer  "inappropriate_count",                        default: 0,         null: false
    t.datetime "pinned_at"
    t.float    "score"
    t.float    "percent_rank",                               default: 1.0,       null: false
    t.integer  "notify_user_count",                          default: 0,         null: false
    t.string   "subtype"
    t.string   "slug"
    t.datetime "auto_close_at"
    t.integer  "auto_close_user_id"
    t.datetime "auto_close_started_at"
    t.integer  "deleted_by_id"
    t.integer  "participant_count",                          default: 1
    t.integer  "word_count"
    t.string   "excerpt",                       limit: 1000
    t.boolean  "pinned_globally",                            default: false,     null: false
    t.boolean  "auto_close_based_on_last_post",              default: false
    t.float    "auto_close_hours"
    t.integer  "chapter_id"
    t.integer  "position",                                   default: -1,        null: false
    t.integer  "parent_topic_id"
    t.datetime "pinned_until"
    t.string   "fancy_title",                   limit: 400
  end

  add_index "topics", ["bumped_at"], name: "index_topics_on_bumped_at", order: {"bumped_at"=>:desc}, using: :btree
  add_index "topics", ["chapter_id"], name: "index_topics_on_chapter_id", using: :btree
  add_index "topics", ["created_at", "visible"], name: "index_topics_on_created_at_and_visible", where: "((deleted_at IS NULL) AND ((archetype)::text <> 'private_message'::text))", using: :btree
  add_index "topics", ["deleted_at", "visible", "archetype", "category_id", "id"], name: "idx_topics_front_page", using: :btree
  add_index "topics", ["id", "deleted_at"], name: "index_topics_on_id_and_deleted_at", using: :btree
  add_index "topics", ["pinned_at"], name: "index_topics_on_pinned_at", where: "(pinned_at IS NOT NULL)", using: :btree
  add_index "topics", ["pinned_globally"], name: "index_topics_on_pinned_globally", where: "pinned_globally", using: :btree
  add_index "topics", ["position"], name: "index_topics_on_position", using: :btree
  add_index "topics", ["user_id"], name: "idx_topics_user_id_deleted_at", where: "(deleted_at IS NULL)", using: :btree

  create_table "twitter_user_infos", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.string   "screen_name",               null: false
    t.integer  "twitter_user_id", limit: 8, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "twitter_user_infos", ["twitter_user_id"], name: "index_twitter_user_infos_on_twitter_user_id", unique: true, using: :btree
  add_index "twitter_user_infos", ["user_id"], name: "index_twitter_user_infos_on_user_id", unique: true, using: :btree

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.string   "original_filename",              null: false
    t.integer  "filesize",                       null: false
    t.integer  "width"
    t.integer  "height"
    t.string   "url",                            null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "sha1",              limit: 40
    t.string   "origin",            limit: 1000
    t.integer  "retain_hours"
  end

  add_index "uploads", ["id", "url"], name: "index_uploads_on_id_and_url", using: :btree
  add_index "uploads", ["sha1"], name: "index_uploads_on_sha1", unique: true, using: :btree
  add_index "uploads", ["url"], name: "index_uploads_on_url", using: :btree
  add_index "uploads", ["user_id"], name: "index_uploads_on_user_id", using: :btree

  create_table "user_actions", force: :cascade do |t|
    t.integer  "action_type",     null: false
    t.integer  "user_id",         null: false
    t.integer  "target_topic_id"
    t.integer  "target_post_id"
    t.integer  "target_user_id"
    t.integer  "acting_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "queued_post_id"
  end

  add_index "user_actions", ["acting_user_id"], name: "index_user_actions_on_acting_user_id", using: :btree
  add_index "user_actions", ["action_type", "user_id", "target_topic_id", "target_post_id", "acting_user_id"], name: "idx_unique_rows", unique: true, using: :btree
  add_index "user_actions", ["target_post_id"], name: "index_user_actions_on_target_post_id", using: :btree
  add_index "user_actions", ["user_id", "action_type"], name: "index_user_actions_on_user_id_and_action_type", using: :btree
  add_index "user_actions", ["user_id", "created_at", "action_type"], name: "idx_user_actions_speed_up_user_all", using: :btree

  create_table "user_avatars", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.integer  "custom_upload_id"
    t.integer  "gravatar_upload_id"
    t.datetime "last_gravatar_download_attempt"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "user_avatars", ["user_id"], name: "index_user_avatars_on_user_id", using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "badge_id",                    null: false
    t.integer  "user_id",                     null: false
    t.datetime "granted_at",                  null: false
    t.integer  "granted_by_id",               null: false
    t.integer  "post_id"
    t.integer  "notification_id"
    t.integer  "seq",             default: 0, null: false
  end

  add_index "user_badges", ["badge_id", "user_id", "post_id"], name: "index_user_badges_on_badge_id_and_user_id_and_post_id", unique: true, where: "(post_id IS NOT NULL)", using: :btree
  add_index "user_badges", ["badge_id", "user_id", "seq"], name: "index_user_badges_on_badge_id_and_user_id_and_seq", unique: true, where: "(post_id IS NULL)", using: :btree
  add_index "user_badges", ["badge_id", "user_id"], name: "index_user_badges_on_badge_id_and_user_id", using: :btree
  add_index "user_badges", ["user_id"], name: "index_user_badges_on_user_id", using: :btree

  create_table "user_custom_fields", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "name",       limit: 256, null: false
    t.text     "value"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_custom_fields", ["user_id", "name"], name: "index_user_custom_fields_on_user_id_and_name", using: :btree

  create_table "user_exports", force: :cascade do |t|
    t.string   "file_name",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_field_options", force: :cascade do |t|
    t.integer  "user_field_id", null: false
    t.string   "value",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_fields", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "field_type",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "editable",        default: false, null: false
    t.string   "description",                     null: false
    t.boolean  "required",        default: true,  null: false
    t.boolean  "show_on_profile", default: false, null: false
    t.integer  "position",        default: 0
  end

  create_table "user_histories", force: :cascade do |t|
    t.integer  "action",                         null: false
    t.integer  "acting_user_id"
    t.integer  "target_user_id"
    t.text     "details"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "context"
    t.string   "ip_address"
    t.string   "email"
    t.text     "subject"
    t.text     "previous_value"
    t.text     "new_value"
    t.integer  "topic_id"
    t.boolean  "admin_only",     default: false
    t.integer  "post_id"
    t.string   "custom_type"
    t.integer  "category_id"
  end

  add_index "user_histories", ["acting_user_id", "action", "id"], name: "index_user_histories_on_acting_user_id_and_action_and_id", using: :btree
  add_index "user_histories", ["action", "id"], name: "index_user_histories_on_action_and_id", using: :btree
  add_index "user_histories", ["category_id"], name: "index_user_histories_on_category_id", using: :btree
  add_index "user_histories", ["subject", "id"], name: "index_user_histories_on_subject_and_id", using: :btree
  add_index "user_histories", ["target_user_id", "id"], name: "index_user_histories_on_target_user_id_and_id", using: :btree

  create_table "user_open_ids", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "email",      null: false
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active",     null: false
  end

  add_index "user_open_ids", ["url"], name: "index_user_open_ids_on_url", using: :btree

  create_table "user_profile_views", force: :cascade do |t|
    t.integer  "user_profile_id", null: false
    t.datetime "viewed_at",       null: false
    t.inet     "ip_address",      null: false
    t.integer  "user_id"
  end

  add_index "user_profile_views", ["user_id"], name: "index_user_profile_views_on_user_id", using: :btree
  add_index "user_profile_views", ["user_profile_id"], name: "index_user_profile_views_on_user_profile_id", using: :btree
  add_index "user_profile_views", ["viewed_at", "ip_address", "user_profile_id"], name: "unique_profile_view_ip", unique: true, where: "(user_id IS NULL)", using: :btree
  add_index "user_profile_views", ["viewed_at", "user_id", "user_profile_id"], name: "unique_profile_view_user", unique: true, where: "(user_id IS NOT NULL)", using: :btree

  create_table "user_profiles", primary_key: "user_id", force: :cascade do |t|
    t.string  "location"
    t.string  "website"
    t.text    "bio_raw"
    t.text    "bio_cooked"
    t.string  "profile_background",   limit: 255
    t.integer "dismissed_banner_key"
    t.integer "bio_cooked_version"
    t.boolean "badge_granted_title",              default: false
    t.string  "card_background",      limit: 255
    t.integer "card_image_badge_id"
    t.integer "views",                            default: 0,     null: false
  end

  add_index "user_profiles", ["bio_cooked_version"], name: "index_user_profiles_on_bio_cooked_version", using: :btree

  create_table "user_search_data", primary_key: "user_id", force: :cascade do |t|
    t.tsvector "search_data"
    t.text     "raw_data"
    t.text     "locale"
  end

  add_index "user_search_data", ["search_data"], name: "idx_search_user", using: :gin

  create_table "user_stats", primary_key: "user_id", force: :cascade do |t|
    t.integer  "topics_entered",        default: 0, null: false
    t.integer  "time_read",             default: 0, null: false
    t.integer  "days_visited",          default: 0, null: false
    t.integer  "posts_read_count",      default: 0, null: false
    t.integer  "likes_given",           default: 0, null: false
    t.integer  "likes_received",        default: 0, null: false
    t.integer  "topic_reply_count",     default: 0, null: false
    t.datetime "new_since",                         null: false
    t.datetime "read_faq"
    t.datetime "first_post_created_at"
    t.integer  "post_count",            default: 0, null: false
    t.integer  "topic_count",           default: 0, null: false
  end

  create_table "user_visits", force: :cascade do |t|
    t.integer "user_id",                    null: false
    t.date    "visited_at",                 null: false
    t.integer "posts_read", default: 0
    t.boolean "mobile",     default: false
  end

  add_index "user_visits", ["user_id", "visited_at"], name: "index_user_visits_on_user_id_and_visited_at", unique: true, using: :btree
  add_index "user_visits", ["visited_at", "mobile"], name: "index_user_visits_on_visited_at_and_mobile", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                      limit: 60,                  null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "name"
    t.integer  "seen_notification_id",                      default: 0,     null: false
    t.datetime "last_posted_at"
    t.string   "email",                         limit: 513,                 null: false
    t.string   "password_hash",                 limit: 64
    t.string   "salt",                          limit: 32
    t.boolean  "active",                                    default: false, null: false
    t.string   "username_lower",                limit: 60,                  null: false
    t.string   "auth_token",                    limit: 32
    t.datetime "last_seen_at"
    t.boolean  "admin",                                     default: false, null: false
    t.datetime "last_emailed_at"
    t.boolean  "email_digests",                                             null: false
    t.integer  "trust_level",                                               null: false
    t.boolean  "email_private_messages",                    default: true
    t.boolean  "email_direct",                              default: true,  null: false
    t.boolean  "approved",                                  default: false, null: false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.integer  "digest_after_days"
    t.datetime "previous_visit_at"
    t.datetime "suspended_at"
    t.datetime "suspended_till"
    t.date     "date_of_birth"
    t.integer  "auto_track_topics_after_msecs"
    t.integer  "views",                                     default: 0,     null: false
    t.integer  "flag_level",                                default: 0,     null: false
    t.inet     "ip_address"
    t.integer  "new_topic_duration_minutes"
    t.boolean  "external_links_in_new_tab",                                 null: false
    t.boolean  "enable_quoting",                            default: true,  null: false
    t.boolean  "moderator",                                 default: false
    t.boolean  "blocked",                                   default: false
    t.boolean  "dynamic_favicon",                           default: false, null: false
    t.string   "title"
    t.integer  "uploaded_avatar_id"
    t.boolean  "email_always",                              default: false, null: false
    t.boolean  "mailing_list_mode",                         default: false, null: false
    t.string   "locale",                        limit: 10
    t.integer  "primary_group_id"
    t.inet     "registration_ip_address"
    t.datetime "last_redirected_to_top_at"
    t.boolean  "disable_jump_reply",                        default: false, null: false
    t.boolean  "edit_history_public",                       default: false, null: false
    t.boolean  "trust_level_locked",                        default: false, null: false
    t.string   "report_uri_hash"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree
  add_index "users", ["id"], name: "idx_users_admin", where: "admin", using: :btree
  add_index "users", ["id"], name: "idx_users_moderator", where: "moderator", using: :btree
  add_index "users", ["last_posted_at"], name: "index_users_on_last_posted_at", using: :btree
  add_index "users", ["last_seen_at"], name: "index_users_on_last_seen_at", using: :btree
  add_index "users", ["report_uri_hash"], name: "index_users_on_report_uri_hash", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
  add_index "users", ["username_lower"], name: "index_users_on_username_lower", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["number"], name: "index_versions_on_number", using: :btree
  add_index "versions", ["tag"], name: "index_versions_on_tag", using: :btree
  add_index "versions", ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type", using: :btree
  add_index "versions", ["user_name"], name: "index_versions_on_user_name", using: :btree
  add_index "versions", ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type", using: :btree

  create_table "warnings", force: :cascade do |t|
    t.integer  "topic_id",      null: false
    t.integer  "user_id",       null: false
    t.integer  "created_by_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "warnings", ["topic_id"], name: "index_warnings_on_topic_id", unique: true, using: :btree
  add_index "warnings", ["user_id"], name: "index_warnings_on_user_id", using: :btree

  add_foreign_key "csp_reports_domains", "users"
  add_foreign_key "csp_reports_reports", "csp_reports_domains"
end
