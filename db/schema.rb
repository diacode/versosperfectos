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

ActiveRecord::Schema.define(:version => 20141206125810) do

  create_table "City", :primary_key => "ID", :force => true do |t|
    t.string  "Name",        :limit => 35, :default => "", :null => false
    t.string  "CountryCode", :limit => 3,  :default => "", :null => false
    t.string  "District",    :limit => 20, :default => "", :null => false
    t.integer "Population",                :default => 0,  :null => false
  end

  create_table "Country", :primary_key => "Code", :force => true do |t|
    t.string  "Name",           :limit => 52, :default => "",     :null => false
    t.string  "Continent",      :limit => 13, :default => "Asia", :null => false
    t.string  "Region",         :limit => 26, :default => "",     :null => false
    t.float   "SurfaceArea",    :limit => 10, :default => 0.0,    :null => false
    t.integer "IndepYear",      :limit => 2
    t.integer "Population",                   :default => 0,      :null => false
    t.float   "LifeExpectancy", :limit => 3
    t.float   "GNP",            :limit => 10
    t.float   "GNPOld",         :limit => 10
    t.string  "LocalName",      :limit => 45, :default => "",     :null => false
    t.string  "GovernmentForm", :limit => 45, :default => "",     :null => false
    t.string  "HeadOfState",    :limit => 60
    t.integer "Capital"
    t.string  "Code2",          :limit => 2,  :default => "",     :null => false
  end

  create_table "CountryLanguage", :id => false, :force => true do |t|
    t.string "CountryCode", :limit => 3,  :default => "",  :null => false
    t.string "Language",    :limit => 30, :default => "",  :null => false
    t.string "IsOfficial",  :limit => 1,  :default => "F", :null => false
    t.float  "Percentage",  :limit => 4,  :default => 0.0, :null => false
  end

  create_table "album_likes", :id => false, :force => true do |t|
    t.integer "user_id",  :limit => 3, :null => false
    t.integer "album_id",              :null => false
  end

  add_index "album_likes", ["user_id"], :name => "FK_UDF_USUARIO"

  create_table "album_ratings", :force => true do |t|
    t.integer "album_id",              :null => false
    t.integer "user_id",  :limit => 3, :null => false
    t.float   "score",    :limit => 3, :null => false
  end

  add_index "album_ratings", ["album_id"], :name => "FK_DISCO"

  create_table "albums", :force => true do |t|
    t.text    "title",                                                          :null => false
    t.integer "year",                                                           :null => false
    t.date    "release_date"
    t.string  "format",                :limit => 3
    t.boolean "demo",                                        :default => false, :null => false
    t.integer "artist_id",                                                      :null => false
    t.integer "alias_id"
    t.string  "slug",                                                           :null => false
    t.integer "visits",                :limit => 8,          :default => 0,     :null => false
    t.integer "rank",                                        :default => 0,     :null => false
    t.float   "average_rating",                              :default => 0.0,   :null => false
    t.integer "vote_count",                                  :default => 0,     :null => false
    t.boolean "block_lyrics",                                :default => false, :null => false
    t.text    "info",                  :limit => 2147483647
    t.integer "cds",                                         :default => 1,     :null => false
    t.integer "record_label_id"
    t.integer "inserter_id"
    t.integer "trimester_planned",     :limit => 1
    t.integer "fav_count",                                   :default => 0,     :null => false
    t.string  "spotify_identifier",    :limit => 23
    t.string  "cover"
    t.text    "soundcloud_embed_code"
    t.text    "bandcamp_embed_code"
  end

  add_index "albums", ["alias_id"], :name => "FK_AUTOR_ALIAS"
  add_index "albums", ["artist_id"], :name => "FK_AUTOR_DISCO"
  add_index "albums", ["inserter_id"], :name => "FK_AUTOR_POSTEADOR"
  add_index "albums", ["record_label_id"], :name => "FK_disco_1"
  add_index "albums", ["slug"], :name => "UNQ_PERMALINK_DISCO", :unique => true

  create_table "aliases", :force => true do |t|
    t.integer "artist_id", :null => false
    t.text    "name",      :null => false
  end

  add_index "aliases", ["artist_id"], :name => "FK_autor_alias_1"

  create_table "artist_likes", :id => false, :force => true do |t|
    t.integer "user_id",   :limit => 3, :null => false
    t.integer "artist_id",              :null => false
  end

  add_index "artist_likes", ["artist_id"], :name => "FK_UAF_AUTOR"
  add_index "artist_likes", ["user_id", "artist_id"], :name => "index_artist_likes_on_user_id_and_artist_id"
  add_index "artist_likes", ["user_id"], :name => "FK_UAF_USUARIO"

  create_table "artists", :force => true do |t|
    t.text    "name",                                                    :null => false
    t.text    "real_name"
    t.boolean "international",                        :default => false, :null => false
    t.text    "bio",            :limit => 2147483647
    t.integer "management_id"
    t.boolean "mc",                                   :default => false, :null => false
    t.boolean "producer",                             :default => false, :null => false
    t.boolean "dj",                                   :default => false, :null => false
    t.boolean "clip_director",                        :default => false, :null => false
    t.boolean "group",                                :default => false, :null => false
    t.text    "web"
    t.text    "myspace"
    t.string  "slug",           :limit => 200,                           :null => false
    t.boolean "dissolved",                            :default => false, :null => false
    t.integer "inserter_id"
    t.date    "birth_date"
    t.date    "death_date"
    t.string  "twitter",        :limit => 15
    t.integer "birth_place_id"
    t.string  "portrait"
    t.string  "soundcloud"
    t.integer "fav_count",                            :default => 0
    t.string  "facebook_url"
  end

  add_index "artists", ["inserter_id"], :name => "FK_autor2posteador"
  add_index "artists", ["management_id"], :name => "FK_autor2management"
  add_index "artists", ["slug"], :name => "IDX_PERMALINK"
  add_index "artists", ["slug"], :name => "UNQ_PERMALINK", :unique => true

  create_table "artworks", :force => true do |t|
    t.string   "title"
    t.string   "art"
    t.integer  "punchline_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "autor_foto", :force => true do |t|
    t.text     "titulo"
    t.integer  "id_autor",     :null => false
    t.datetime "fecha_subida"
    t.integer  "id_posteador"
  end

  add_index "autor_foto", ["id_autor"], :name => "autor_foto2autor"
  add_index "autor_foto", ["id_posteador"], :name => "autor_foto2posteador"

  create_table "band_memberships", :id => false, :force => true do |t|
    t.integer "group_id",  :null => false
    t.integer "member_id", :null => false
  end

  add_index "band_memberships", ["member_id"], :name => "FK_FORMACION2MIEMBRO"

  create_table "banners", :force => true do |t|
    t.string   "name"
    t.text     "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.text   "name",               :null => false
    t.string "slug", :limit => 40, :null => false
  end

  add_index "categories", ["slug"], :name => "UNQ_CATEGORIA_PERMALINK", :unique => true

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "post_id",     :null => false
    t.integer "category_id", :null => false
  end

  add_index "categories_posts", ["category_id"], :name => "FK_NOTCAT2CAT"

  create_table "comentario_karma", :id => false, :force => true do |t|
    t.integer "id_usuario",    :limit => 3, :default => 0, :null => false
    t.integer "id_comentario",              :default => 0, :null => false
    t.integer "valor",         :limit => 1,                :null => false
  end

  add_index "comentario_karma", ["id_comentario"], :name => "FK_COMENTARIOKARMA2COMENTARIO"

  create_table "comments", :force => true do |t|
    t.text     "content",    :limit => 2147483647,                :null => false
    t.integer  "user_id",    :limit => 3,                         :null => false
    t.integer  "post_id",                                         :null => false
    t.datetime "created_at",                                      :null => false
    t.integer  "karma",                            :default => 0, :null => false
  end

  add_index "comments", ["post_id"], :name => "FK_COMENTARIO2NOTICIA"
  add_index "comments", ["user_id"], :name => "FK_COMENTARIO2USUARIO"

  create_table "correccion_letra", :force => true do |t|
    t.integer  "id_cancion",                            :null => false
    t.integer  "id_corrector",    :limit => 3,          :null => false
    t.text     "letra_corregida", :limit => 2147483647, :null => false
    t.text     "comentario",                            :null => false
    t.datetime "fecha_envio",                           :null => false
  end

  add_index "correccion_letra", ["id_cancion"], :name => "CORRECCIONL2CANCION"
  add_index "correccion_letra", ["id_corrector"], :name => "CORRECCIONL2USUARIO"

  create_table "disco_album_ranking", :id => false, :force => true do |t|
    t.integer "id_disco",                   :null => false
    t.boolean "internacional",              :null => false
    t.integer "num_semana",                 :null => false
    t.integer "year",                       :null => false
    t.float   "puntuacion",    :limit => 6, :null => false
    t.integer "posicion",                   :null => false
  end

  create_table "disco_resena", :force => true do |t|
    t.text     "introduccion",        :limit => 2147483647,                    :null => false
    t.text     "letras",              :limit => 2147483647
    t.text     "produccion",          :limit => 2147483647,                    :null => false
    t.text     "colaboraciones",      :limit => 2147483647
    t.text     "diseno",              :limit => 2147483647
    t.float    "nota_letras"
    t.float    "nota_produccion",                                              :null => false
    t.float    "nota_colaboraciones"
    t.float    "nota_diseno"
    t.text     "conclusion",          :limit => 2147483647,                    :null => false
    t.integer  "id_disco",                                                     :null => false
    t.integer  "id_autor_resena"
    t.datetime "fecha"
    t.integer  "id_enviador",         :limit => 3
    t.boolean  "borrador",                                  :default => false, :null => false
    t.integer  "id_validador"
    t.datetime "fecha_envio"
    t.integer  "tipo",                :limit => 1,          :default => 0,     :null => false
    t.integer  "karma",                                     :default => 0,     :null => false
  end

  add_index "disco_resena", ["id_autor_resena"], :name => "FK_RESENA2STAFF"
  add_index "disco_resena", ["id_disco"], :name => "FK_RESENA2DISCO"
  add_index "disco_resena", ["id_enviador"], :name => "FK_RESENA2ENVIADOR"
  add_index "disco_resena", ["id_validador"], :name => "FK_RESENA2VALIDADOR"

  create_table "disco_resena_sin_validar", :force => true do |t|
    t.text     "introduccion",        :limit => 2147483647,                    :null => false
    t.text     "letras",              :limit => 2147483647
    t.text     "produccion",          :limit => 2147483647,                    :null => false
    t.text     "colaboraciones",      :limit => 2147483647
    t.text     "diseno",              :limit => 2147483647
    t.float    "nota_letras"
    t.float    "nota_produccion",                                              :null => false
    t.float    "nota_colaboraciones"
    t.float    "nota_diseno"
    t.text     "conclusion",          :limit => 2147483647,                    :null => false
    t.integer  "id_disco"
    t.integer  "id_enviador",         :limit => 3,                             :null => false
    t.boolean  "borrador",                                  :default => false, :null => false
    t.datetime "fecha_envio"
    t.integer  "tipo",                :limit => 1,          :default => 0,     :null => false
  end

  add_index "disco_resena_sin_validar", ["id_disco"], :name => "FK_RESENASV2DISCO"
  add_index "disco_resena_sin_validar", ["id_enviador"], :name => "FK_RESENASV2ENVIADOR"

  create_table "entrevista", :force => true do |t|
    t.text     "contenido",           :limit => 2147483647, :null => false
    t.datetime "fecha_publicacion",                         :null => false
    t.date     "fecha_realizacion",                         :null => false
    t.integer  "id_entrevistado"
    t.text     "entrevistado_alt"
    t.integer  "id_autor_entrevista"
  end

  add_index "entrevista", ["id_autor_entrevista"], :name => "FK_ENTREVISTA2AUTOR"
  add_index "entrevista", ["id_entrevistado"], :name => "FK_ENTREVISTA2ENTREVISTADO"

  create_table "evento", :force => true do |t|
    t.text    "titulo",                                                                                     :null => false
    t.string  "permalink",          :limit => 200,                                                          :null => false
    t.integer "id_municipio",                                                                               :null => false
    t.text    "direccion",                                                                                  :null => false
    t.text    "descripcion",        :limit => 2147483647
    t.boolean "cartel",                                                                  :default => false, :null => false
    t.decimal "latitud",                                  :precision => 10, :scale => 8
    t.decimal "longitud",                                 :precision => 10, :scale => 8
    t.decimal "precio_anticipada",                        :precision => 4,  :scale => 2
    t.decimal "precio_taquilla",                          :precision => 4,  :scale => 2
    t.boolean "precio_gratis",                                                           :default => false, :null => false
    t.boolean "precio_descripcion",                                                      :default => false, :null => false
    t.integer "id_cronica"
  end

  add_index "evento", ["id_cronica"], :name => "FK_EVENTO2CRONICA"
  add_index "evento", ["id_municipio"], :name => "FK_EVENTO2MUNICIPIO"
  add_index "evento", ["permalink"], :name => "UNQ_EVTPERMALINK", :unique => true

  create_table "evento_asistente", :id => false, :force => true do |t|
    t.integer "id_evento",                 :null => false
    t.integer "id_asistente", :limit => 3, :null => false
  end

  add_index "evento_asistente", ["id_asistente"], :name => "FK_EVTASIST2ASIST"

  create_table "evento_cronica", :force => true do |t|
    t.text     "contenido",          :limit => 2147483647,                   :null => false
    t.integer  "id_editor"
    t.datetime "fecha_publicacion"
    t.boolean  "borrador",                                 :default => true, :null => false
    t.datetime "fecha_modificacion",                                         :null => false
  end

  add_index "evento_cronica", ["id_editor"], :name => "FK_EVTCRONICA2STAFF"

  create_table "evento_fecha", :id => false, :force => true do |t|
    t.integer "id_evento", :null => false
    t.date    "fecha",     :null => false
  end

  add_index "evento_fecha", ["id_evento"], :name => "FK_EVTFECHA2EVT"

  create_table "evento_foto", :force => true do |t|
    t.integer  "id_evento",    :null => false
    t.integer  "id_posteador"
    t.text     "titulo"
    t.datetime "fecha_subida"
  end

  add_index "evento_foto", ["id_evento"], :name => "FK_EVTFOTO2EVENTO"
  add_index "evento_foto", ["id_posteador"], :name => "FK_EVTFOTO2STAFF"

  create_table "evento_foto_etiquetado", :id => false, :force => true do |t|
    t.string  "id_foto",  :limit => 15, :null => false
    t.integer "id_autor",               :null => false
    t.integer "ancho",                  :null => false
    t.integer "alto",                   :null => false
    t.integer "x",                      :null => false
    t.integer "y",                      :null => false
  end

  add_index "evento_foto_etiquetado", ["id_autor"], :name => "FK_ETQ2AUTOR"

  create_table "evento_participante", :id => false, :force => true do |t|
    t.integer "id_evento",       :null => false
    t.integer "id_participante", :null => false
  end

  add_index "evento_participante", ["id_participante"], :name => "FK_EVTPART2PART"

  create_table "featured_blocks", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.string   "poster"
    t.integer  "slot"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "featurings", :force => true do |t|
    t.integer "song_id",                          :null => false
    t.integer "artist_id",                        :null => false
    t.boolean "collaboration", :default => false, :null => false
    t.boolean "mc",            :default => false, :null => false
    t.boolean "producer",      :default => false, :null => false
    t.boolean "dj",            :default => false, :null => false
    t.boolean "clip_director", :default => false, :null => false
  end

  add_index "featurings", ["artist_id"], :name => "FK_AUTOR"

  create_table "foro_attachments", :primary_key => "ID_ATTACH", :force => true do |t|
    t.integer "ID_THUMB",                      :default => 0,  :null => false
    t.integer "ID_MSG",                        :default => 0,  :null => false
    t.integer "ID_MEMBER",      :limit => 3,   :default => 0,  :null => false
    t.integer "attachmentType", :limit => 1,   :default => 0,  :null => false
    t.text    "filename",       :limit => 255,                 :null => false
    t.integer "size",                          :default => 0,  :null => false
    t.integer "downloads",      :limit => 3,   :default => 0,  :null => false
    t.integer "width",          :limit => 3,   :default => 0,  :null => false
    t.integer "height",         :limit => 3,   :default => 0,  :null => false
    t.string  "file_hash",      :limit => 40,  :default => "", :null => false
  end

  add_index "foro_attachments", ["ID_MEMBER", "ID_ATTACH"], :name => "ID_MEMBER", :unique => true
  add_index "foro_attachments", ["ID_MSG"], :name => "ID_MSG"

  create_table "foro_ban_groups", :primary_key => "ID_BAN_GROUP", :force => true do |t|
    t.string  "name",            :limit => 20,  :default => "", :null => false
    t.integer "ban_time",                       :default => 0,  :null => false
    t.integer "expire_time"
    t.integer "cannot_access",   :limit => 1,   :default => 0,  :null => false
    t.integer "cannot_register", :limit => 1,   :default => 0,  :null => false
    t.integer "cannot_post",     :limit => 1,   :default => 0,  :null => false
    t.integer "cannot_login",    :limit => 1,   :default => 0,  :null => false
    t.text    "reason",          :limit => 255,                 :null => false
    t.text    "notes",                                          :null => false
  end

  create_table "foro_ban_items", :primary_key => "ID_BAN", :force => true do |t|
    t.integer "ID_BAN_GROUP",  :limit => 2,   :default => 0, :null => false
    t.integer "ip_low1",       :limit => 1,   :default => 0, :null => false
    t.integer "ip_high1",      :limit => 1,   :default => 0, :null => false
    t.integer "ip_low2",       :limit => 1,   :default => 0, :null => false
    t.integer "ip_high2",      :limit => 1,   :default => 0, :null => false
    t.integer "ip_low3",       :limit => 1,   :default => 0, :null => false
    t.integer "ip_high3",      :limit => 1,   :default => 0, :null => false
    t.integer "ip_low4",       :limit => 1,   :default => 0, :null => false
    t.integer "ip_high4",      :limit => 1,   :default => 0, :null => false
    t.text    "hostname",      :limit => 255,                :null => false
    t.text    "email_address", :limit => 255,                :null => false
    t.integer "ID_MEMBER",     :limit => 3,   :default => 0, :null => false
    t.integer "hits",          :limit => 3,   :default => 0, :null => false
  end

  add_index "foro_ban_items", ["ID_BAN_GROUP"], :name => "ID_BAN_GROUP"

  create_table "foro_board_permissions", :id => false, :force => true do |t|
    t.integer "ID_GROUP",   :limit => 2,  :default => 0,  :null => false
    t.integer "ID_BOARD",   :limit => 2,  :default => 0,  :null => false
    t.string  "permission", :limit => 30, :default => "", :null => false
    t.integer "addDeny",    :limit => 1,  :default => 1,  :null => false
  end

  create_table "foro_boards", :primary_key => "ID_BOARD", :force => true do |t|
    t.integer "ID_CAT",          :limit => 1,   :default => 0,      :null => false
    t.integer "childLevel",      :limit => 1,   :default => 0,      :null => false
    t.integer "ID_PARENT",       :limit => 2,   :default => 0,      :null => false
    t.integer "boardOrder",      :limit => 2,   :default => 0,      :null => false
    t.integer "ID_LAST_MSG",                    :default => 0,      :null => false
    t.integer "ID_MSG_UPDATED",                 :default => 0,      :null => false
    t.string  "memberGroups",                   :default => "-1,0", :null => false
    t.text    "name",            :limit => 255,                     :null => false
    t.text    "description",                                        :null => false
    t.integer "numTopics",       :limit => 3,   :default => 0,      :null => false
    t.integer "numPosts",        :limit => 3,   :default => 0,      :null => false
    t.integer "countPosts",      :limit => 1,   :default => 0,      :null => false
    t.integer "ID_THEME",        :limit => 1,   :default => 0,      :null => false
    t.integer "permission_mode", :limit => 1,   :default => 0,      :null => false
    t.integer "override_theme",  :limit => 1,   :default => 0,      :null => false
  end

  add_index "foro_boards", ["ID_CAT", "ID_BOARD"], :name => "categories", :unique => true
  add_index "foro_boards", ["ID_MSG_UPDATED"], :name => "ID_MSG_UPDATED"
  add_index "foro_boards", ["ID_PARENT"], :name => "ID_PARENT"
  add_index "foro_boards", ["memberGroups"], :name => "memberGroups", :length => {"memberGroups"=>48}

  create_table "foro_calendar", :primary_key => "ID_EVENT", :force => true do |t|
    t.date    "startDate",               :default => '0001-01-01', :null => false
    t.date    "endDate",                 :default => '0001-01-01', :null => false
    t.integer "ID_BOARD",  :limit => 2,  :default => 0,            :null => false
    t.integer "ID_TOPIC",  :limit => 3,  :default => 0,            :null => false
    t.string  "title",     :limit => 48, :default => "",           :null => false
    t.integer "ID_MEMBER", :limit => 3,  :default => 0,            :null => false
  end

  add_index "foro_calendar", ["ID_TOPIC", "ID_MEMBER"], :name => "topic"
  add_index "foro_calendar", ["endDate"], :name => "endDate"
  add_index "foro_calendar", ["startDate"], :name => "startDate"

  create_table "foro_calendar_holidays", :primary_key => "ID_HOLIDAY", :force => true do |t|
    t.date   "eventDate",               :default => '0001-01-01', :null => false
    t.string "title",     :limit => 30, :default => "",           :null => false
  end

  add_index "foro_calendar_holidays", ["eventDate"], :name => "eventDate"

  create_table "foro_categories", :primary_key => "ID_CAT", :force => true do |t|
    t.integer "catOrder",    :limit => 1,   :default => 0,    :null => false
    t.text    "name",        :limit => 255,                   :null => false
    t.boolean "canCollapse",                :default => true, :null => false
  end

  create_table "foro_collapsed_categories", :id => false, :force => true do |t|
    t.integer "ID_CAT",    :limit => 1, :default => 0, :null => false
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
  end

  create_table "foro_log_actions", :primary_key => "ID_ACTION", :force => true do |t|
    t.integer "logTime",                 :default => 0,  :null => false
    t.integer "ID_MEMBER", :limit => 3,  :default => 0,  :null => false
    t.string  "ip",        :limit => 16, :default => "", :null => false
    t.string  "action",    :limit => 30, :default => "", :null => false
    t.text    "extra",                                   :null => false
  end

  add_index "foro_log_actions", ["ID_MEMBER"], :name => "ID_MEMBER"
  add_index "foro_log_actions", ["logTime"], :name => "logTime"

  create_table "foro_log_activity", :primary_key => "date", :force => true do |t|
    t.integer "hits",      :limit => 3, :default => 0, :null => false
    t.integer "topics",    :limit => 2, :default => 0, :null => false
    t.integer "posts",     :limit => 2, :default => 0, :null => false
    t.integer "registers", :limit => 2, :default => 0, :null => false
    t.integer "mostOn",    :limit => 2, :default => 0, :null => false
  end

  add_index "foro_log_activity", ["hits"], :name => "hits"
  add_index "foro_log_activity", ["mostOn"], :name => "mostOn"

  create_table "foro_log_banned", :primary_key => "ID_BAN_LOG", :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3,   :default => 0,  :null => false
    t.string  "ip",        :limit => 16,  :default => "", :null => false
    t.text    "email",     :limit => 255,                 :null => false
    t.integer "logTime",                  :default => 0,  :null => false
  end

  add_index "foro_log_banned", ["logTime"], :name => "logTime"

  create_table "foro_log_boards", :id => false, :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
    t.integer "ID_BOARD",  :limit => 2, :default => 0, :null => false
    t.integer "ID_MSG",                 :default => 0, :null => false
  end

  create_table "foro_log_errors", :primary_key => "ID_ERROR", :force => true do |t|
    t.integer "logTime",                 :default => 0,  :null => false
    t.integer "ID_MEMBER", :limit => 3,  :default => 0,  :null => false
    t.string  "ip",        :limit => 16, :default => "", :null => false
    t.text    "url",                                     :null => false
    t.text    "message",                                 :null => false
    t.string  "session",   :limit => 32, :default => "", :null => false
  end

  add_index "foro_log_errors", ["ID_MEMBER"], :name => "ID_MEMBER"
  add_index "foro_log_errors", ["ip"], :name => "ip"
  add_index "foro_log_errors", ["logTime"], :name => "logTime"

  create_table "foro_log_floodcontrol", :primary_key => "ip", :force => true do |t|
    t.integer "logTime", :default => 0, :null => false
  end

  create_table "foro_log_karma", :id => false, :force => true do |t|
    t.integer "ID_TARGET",   :limit => 3, :default => 0, :null => false
    t.integer "ID_EXECUTOR", :limit => 3, :default => 0, :null => false
    t.integer "logTime",                  :default => 0, :null => false
    t.integer "action",      :limit => 1, :default => 0, :null => false
  end

  add_index "foro_log_karma", ["logTime"], :name => "logTime"

  create_table "foro_log_mark_read", :id => false, :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
    t.integer "ID_BOARD",  :limit => 2, :default => 0, :null => false
    t.integer "ID_MSG",                 :default => 0, :null => false
  end

  create_table "foro_log_notify", :id => false, :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3, :default => 0,     :null => false
    t.integer "ID_TOPIC",  :limit => 3, :default => 0,     :null => false
    t.integer "ID_BOARD",  :limit => 2, :default => 0,     :null => false
    t.boolean "sent",                   :default => false, :null => false
  end

  create_table "foro_log_online", :primary_key => "session", :force => true do |t|
    t.timestamp "logTime",                               :null => false
    t.integer   "ID_MEMBER", :limit => 3, :default => 0, :null => false
    t.integer   "ip",                     :default => 0, :null => false
    t.text      "url",                                   :null => false
  end

  add_index "foro_log_online", ["ID_MEMBER"], :name => "ID_MEMBER"
  add_index "foro_log_online", ["logTime"], :name => "logTime"

  create_table "foro_log_polls", :id => false, :force => true do |t|
    t.integer "ID_POLL",   :limit => 3, :default => 0, :null => false
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
    t.integer "ID_CHOICE", :limit => 1, :default => 0, :null => false
  end

  create_table "foro_log_search_messages", :id => false, :force => true do |t|
    t.integer "ID_SEARCH", :limit => 1, :default => 0, :null => false
    t.integer "ID_MSG",                 :default => 0, :null => false
  end

  create_table "foro_log_search_results", :id => false, :force => true do |t|
    t.integer "ID_SEARCH",   :limit => 1, :default => 0, :null => false
    t.integer "ID_TOPIC",    :limit => 3, :default => 0, :null => false
    t.integer "ID_MSG",                   :default => 0, :null => false
    t.integer "relevance",   :limit => 2, :default => 0, :null => false
    t.integer "num_matches", :limit => 2, :default => 0, :null => false
  end

  create_table "foro_log_search_subjects", :id => false, :force => true do |t|
    t.string  "word",     :limit => 20, :default => "", :null => false
    t.integer "ID_TOPIC", :limit => 3,  :default => 0,  :null => false
  end

  add_index "foro_log_search_subjects", ["ID_TOPIC"], :name => "ID_TOPIC"

  create_table "foro_log_search_topics", :id => false, :force => true do |t|
    t.integer "ID_SEARCH", :limit => 1, :default => 0, :null => false
    t.integer "ID_TOPIC",  :limit => 3, :default => 0, :null => false
  end

  create_table "foro_log_topics", :id => false, :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
    t.integer "ID_TOPIC",  :limit => 3, :default => 0, :null => false
    t.integer "ID_MSG",                 :default => 0, :null => false
  end

  add_index "foro_log_topics", ["ID_TOPIC"], :name => "ID_TOPIC"

  create_table "foro_membergroups", :primary_key => "ID_GROUP", :force => true do |t|
    t.string  "groupName",   :limit => 80,  :default => "", :null => false
    t.string  "onlineColor", :limit => 20,  :default => "", :null => false
    t.integer "minPosts",    :limit => 3,   :default => -1, :null => false
    t.integer "maxMessages", :limit => 2,   :default => 0,  :null => false
    t.text    "stars",       :limit => 255,                 :null => false
  end

  add_index "foro_membergroups", ["minPosts"], :name => "minPosts"

  create_table "foro_members", :primary_key => "ID_MEMBER", :force => true do |t|
    t.string  "memberName",          :limit => 80,  :default => "",           :null => false
    t.integer "dateRegistered",                     :default => 0,            :null => false
    t.integer "posts",               :limit => 3,   :default => 0,            :null => false
    t.integer "ID_GROUP",            :limit => 2,   :default => 0,            :null => false
    t.text    "lngfile",             :limit => 255,                           :null => false
    t.integer "lastLogin",                          :default => 0,            :null => false
    t.text    "realName",            :limit => 255,                           :null => false
    t.integer "instantMessages",     :limit => 2,   :default => 0,            :null => false
    t.integer "unreadMessages",      :limit => 2,   :default => 0,            :null => false
    t.text    "buddy_list",                                                   :null => false
    t.text    "pm_ignore_list",      :limit => 255,                           :null => false
    t.text    "messageLabels",                                                :null => false
    t.string  "passwd",              :limit => 64,  :default => "",           :null => false
    t.text    "emailAddress",        :limit => 255,                           :null => false
    t.text    "personalText",        :limit => 255,                           :null => false
    t.integer "gender",              :limit => 1,   :default => 0,            :null => false
    t.date    "birthdate",                          :default => '0001-01-01', :null => false
    t.text    "websiteTitle",        :limit => 255,                           :null => false
    t.text    "websiteUrl",          :limit => 255,                           :null => false
    t.text    "location",            :limit => 255,                           :null => false
    t.text    "ICQ",                 :limit => 255,                           :null => false
    t.string  "AIM",                 :limit => 16,  :default => "",           :null => false
    t.string  "YIM",                 :limit => 32,  :default => "",           :null => false
    t.text    "MSN",                 :limit => 255,                           :null => false
    t.integer "hideEmail",           :limit => 1,   :default => 0,            :null => false
    t.integer "showOnline",          :limit => 1,   :default => 1,            :null => false
    t.string  "timeFormat",          :limit => 80,  :default => "",           :null => false
    t.text    "signature",                                                    :null => false
    t.float   "timeOffset",                         :default => 0.0,          :null => false
    t.text    "avatar",              :limit => 255,                           :null => false
    t.integer "pm_email_notify",     :limit => 1,   :default => 0,            :null => false
    t.integer "karmaBad",            :limit => 2,   :default => 0,            :null => false
    t.integer "karmaGood",           :limit => 2,   :default => 0,            :null => false
    t.text    "usertitle",           :limit => 255,                           :null => false
    t.integer "notifyAnnouncements", :limit => 1,   :default => 1,            :null => false
    t.integer "notifyOnce",          :limit => 1,   :default => 1,            :null => false
    t.integer "notifySendBody",      :limit => 1,   :default => 0,            :null => false
    t.integer "notifyTypes",         :limit => 1,   :default => 2,            :null => false
    t.text    "memberIP",            :limit => 255,                           :null => false
    t.text    "memberIP2",           :limit => 255,                           :null => false
    t.text    "secretQuestion",      :limit => 255,                           :null => false
    t.string  "secretAnswer",        :limit => 64,  :default => "",           :null => false
    t.integer "ID_THEME",            :limit => 1,   :default => 0,            :null => false
    t.integer "is_activated",        :limit => 1,   :default => 1,            :null => false
    t.string  "validation_code",     :limit => 10,  :default => "",           :null => false
    t.integer "ID_MSG_LAST_VISIT",                  :default => 0,            :null => false
    t.text    "additionalGroups",    :limit => 255,                           :null => false
    t.string  "smileySet",           :limit => 48,  :default => "",           :null => false
    t.integer "ID_POST_GROUP",       :limit => 2,   :default => 0,            :null => false
    t.integer "totalTimeLoggedIn",                  :default => 0,            :null => false
    t.string  "passwordSalt",        :limit => 5,   :default => "",           :null => false
  end

  add_index "foro_members", ["ID_GROUP"], :name => "ID_GROUP"
  add_index "foro_members", ["ID_POST_GROUP"], :name => "ID_POST_GROUP"
  add_index "foro_members", ["birthdate"], :name => "birthdate"
  add_index "foro_members", ["dateRegistered"], :name => "dateRegistered"
  add_index "foro_members", ["lastLogin"], :name => "lastLogin"
  add_index "foro_members", ["lngfile"], :name => "lngfile", :length => {"lngfile"=>30}
  add_index "foro_members", ["memberName"], :name => "memberName", :length => {"memberName"=>30}
  add_index "foro_members", ["posts"], :name => "posts"

  create_table "foro_message_icons", :primary_key => "ID_ICON", :force => true do |t|
    t.string  "title",     :limit => 80, :default => "", :null => false
    t.string  "filename",  :limit => 80, :default => "", :null => false
    t.integer "ID_BOARD",  :limit => 3,  :default => 0,  :null => false
    t.integer "iconOrder", :limit => 2,  :default => 0,  :null => false
  end

  add_index "foro_message_icons", ["ID_BOARD"], :name => "ID_BOARD"

  create_table "foro_messages", :primary_key => "ID_MSG", :force => true do |t|
    t.integer "ID_TOPIC",        :limit => 3,   :default => 0,    :null => false
    t.integer "ID_BOARD",        :limit => 2,   :default => 0,    :null => false
    t.integer "posterTime",                     :default => 0,    :null => false
    t.integer "ID_MEMBER",       :limit => 3,   :default => 0,    :null => false
    t.integer "ID_MSG_MODIFIED",                :default => 0,    :null => false
    t.text    "subject",         :limit => 255,                   :null => false
    t.text    "posterName",      :limit => 255,                   :null => false
    t.text    "posterEmail",     :limit => 255,                   :null => false
    t.text    "posterIP",        :limit => 255,                   :null => false
    t.integer "smileysEnabled",  :limit => 1,   :default => 1,    :null => false
    t.integer "modifiedTime",                   :default => 0,    :null => false
    t.text    "modifiedName",    :limit => 255,                   :null => false
    t.text    "body",                                             :null => false
    t.string  "icon",            :limit => 16,  :default => "xx", :null => false
  end

  add_index "foro_messages", ["ID_BOARD", "ID_MSG"], :name => "ID_BOARD", :unique => true
  add_index "foro_messages", ["ID_MEMBER", "ID_BOARD"], :name => "showPosts"
  add_index "foro_messages", ["ID_MEMBER", "ID_MSG"], :name => "ID_MEMBER", :unique => true
  add_index "foro_messages", ["ID_MEMBER", "ID_TOPIC"], :name => "participation"
  add_index "foro_messages", ["ID_TOPIC", "ID_MSG"], :name => "topic", :unique => true
  add_index "foro_messages", ["ID_TOPIC"], :name => "ID_TOPIC"
  add_index "foro_messages", ["posterIP", "ID_TOPIC"], :name => "ipIndex", :length => {"posterIP"=>15, "ID_TOPIC"=>nil}

  create_table "foro_moderators", :id => false, :force => true do |t|
    t.integer "ID_BOARD",  :limit => 2, :default => 0, :null => false
    t.integer "ID_MEMBER", :limit => 3, :default => 0, :null => false
  end

  create_table "foro_package_servers", :primary_key => "ID_SERVER", :force => true do |t|
    t.text "name", :limit => 255, :null => false
    t.text "url",  :limit => 255, :null => false
  end

  create_table "foro_permissions", :id => false, :force => true do |t|
    t.integer "ID_GROUP",   :limit => 2,  :default => 0,  :null => false
    t.string  "permission", :limit => 30, :default => "", :null => false
    t.integer "addDeny",    :limit => 1,  :default => 1,  :null => false
  end

  create_table "foro_personal_messages", :primary_key => "ID_PM", :force => true do |t|
    t.integer "ID_MEMBER_FROM",  :limit => 3,   :default => 0, :null => false
    t.integer "deletedBySender", :limit => 1,   :default => 0, :null => false
    t.text    "fromName",        :limit => 255,                :null => false
    t.integer "msgtime",                        :default => 0, :null => false
    t.text    "subject",         :limit => 255,                :null => false
    t.text    "body",                                          :null => false
  end

  add_index "foro_personal_messages", ["ID_MEMBER_FROM", "deletedBySender"], :name => "ID_MEMBER"
  add_index "foro_personal_messages", ["msgtime"], :name => "msgtime"

  create_table "foro_pm_recipients", :id => false, :force => true do |t|
    t.integer "ID_PM",                   :default => 0,    :null => false
    t.integer "ID_MEMBER", :limit => 3,  :default => 0,    :null => false
    t.string  "labels",    :limit => 60, :default => "-1", :null => false
    t.integer "bcc",       :limit => 1,  :default => 0,    :null => false
    t.integer "is_read",   :limit => 1,  :default => 0,    :null => false
    t.integer "deleted",   :limit => 1,  :default => 0,    :null => false
  end

  add_index "foro_pm_recipients", ["ID_MEMBER", "deleted", "ID_PM"], :name => "ID_MEMBER", :unique => true

  create_table "foro_poll_choices", :id => false, :force => true do |t|
    t.integer "ID_POLL",   :limit => 3,   :default => 0, :null => false
    t.integer "ID_CHOICE", :limit => 1,   :default => 0, :null => false
    t.text    "label",     :limit => 255,                :null => false
    t.integer "votes",     :limit => 2,   :default => 0, :null => false
  end

  create_table "foro_polls", :primary_key => "ID_POLL", :force => true do |t|
    t.text    "question",     :limit => 255,                    :null => false
    t.boolean "votingLocked",                :default => false, :null => false
    t.integer "maxVotes",     :limit => 1,   :default => 1,     :null => false
    t.integer "expireTime",                  :default => 0,     :null => false
    t.integer "hideResults",  :limit => 1,   :default => 0,     :null => false
    t.integer "changeVote",   :limit => 1,   :default => 0,     :null => false
    t.integer "ID_MEMBER",    :limit => 3,   :default => 0,     :null => false
    t.text    "posterName",   :limit => 255,                    :null => false
  end

  create_table "foro_sessions", :primary_key => "session_id", :force => true do |t|
    t.integer "last_update", :null => false
    t.text    "data",        :null => false
  end

  create_table "foro_settings", :id => false, :force => true do |t|
    t.text "variable", :limit => 255, :null => false
    t.text "value",                   :null => false
  end

  create_table "foro_smileys", :primary_key => "ID_SMILEY", :force => true do |t|
    t.string  "code",        :limit => 30, :default => "", :null => false
    t.string  "filename",    :limit => 48, :default => "", :null => false
    t.string  "description", :limit => 80, :default => "", :null => false
    t.integer "smileyRow",   :limit => 1,  :default => 0,  :null => false
    t.integer "smileyOrder", :limit => 2,  :default => 0,  :null => false
    t.integer "hidden",      :limit => 1,  :default => 0,  :null => false
  end

  create_table "foro_themes", :id => false, :force => true do |t|
    t.integer "ID_MEMBER", :limit => 3,   :default => 0, :null => false
    t.integer "ID_THEME",  :limit => 1,   :default => 1, :null => false
    t.text    "variable",  :limit => 255,                :null => false
    t.text    "value",                                   :null => false
  end

  add_index "foro_themes", ["ID_MEMBER"], :name => "ID_MEMBER"

  create_table "foro_topics", :primary_key => "ID_TOPIC", :force => true do |t|
    t.integer "isSticky",          :limit => 1, :default => 0, :null => false
    t.integer "ID_BOARD",          :limit => 2, :default => 0, :null => false
    t.integer "ID_FIRST_MSG",                   :default => 0, :null => false
    t.integer "ID_LAST_MSG",                    :default => 0, :null => false
    t.integer "ID_MEMBER_STARTED", :limit => 3, :default => 0, :null => false
    t.integer "ID_MEMBER_UPDATED", :limit => 3, :default => 0, :null => false
    t.integer "ID_POLL",           :limit => 3, :default => 0, :null => false
    t.integer "numReplies",                     :default => 0, :null => false
    t.integer "numViews",                       :default => 0, :null => false
    t.integer "locked",            :limit => 1, :default => 0, :null => false
  end

  add_index "foro_topics", ["ID_BOARD"], :name => "ID_BOARD"
  add_index "foro_topics", ["ID_FIRST_MSG", "ID_BOARD"], :name => "firstMessage", :unique => true
  add_index "foro_topics", ["ID_LAST_MSG", "ID_BOARD"], :name => "lastMessage", :unique => true
  add_index "foro_topics", ["ID_POLL", "ID_TOPIC"], :name => "poll", :unique => true
  add_index "foro_topics", ["isSticky"], :name => "isSticky"

  create_table "letra_sin_validar", :force => true do |t|
    t.integer  "id_cancion",                        :null => false
    t.integer  "id_enviador", :limit => 3,          :null => false
    t.datetime "fecha_envio",                       :null => false
    t.text     "letra",       :limit => 2147483647, :null => false
  end

  add_index "letra_sin_validar", ["id_cancion"], :name => "FK_LETRASV2CANCION"
  add_index "letra_sin_validar", ["id_enviador"], :name => "FK_LETRASV2USUARIO"

  create_table "log_ip_karma_comentario_noticia", :id => false, :force => true do |t|
    t.integer "id_comentario",                             :null => false
    t.integer "ip",                                        :null => false
    t.integer "modo",          :limit => 1, :default => 1, :null => false
  end

  create_table "log_ip_karma_resena", :id => false, :force => true do |t|
    t.integer "id_resena",                             :null => false
    t.integer "ip",                                    :null => false
    t.integer "modo",      :limit => 1, :default => 1, :null => false
  end

  create_table "log_ip_lectura_noticia", :id => false, :force => true do |t|
    t.integer "id_noticia",              :null => false
    t.integer "ip",         :limit => 8, :null => false
  end

  create_table "log_ip_visita_disco", :id => false, :force => true do |t|
    t.integer "id_disco",              :null => false
    t.integer "ip",       :limit => 8, :null => false
  end

  create_table "managements", :force => true do |t|
    t.text   "name",  :null => false
    t.text   "phone"
    t.text   "fax"
    t.text   "email"
    t.text   "web"
    t.string "slug",  :null => false
  end

  add_index "managements", ["slug"], :name => "UNQ_PERMALINK_MANAG", :unique => true

  create_table "municipio", :force => true do |t|
    t.integer "id_provincia", :limit => 1, :null => false
    t.text    "nombre",                    :null => false
  end

  add_index "municipio", ["id_provincia"], :name => "FK_MUNICIPIO2PROVINCIA"

  create_table "pais", :force => true do |t|
    t.integer "isonum", :limit => 2
    t.string  "iso2",   :limit => 2
    t.string  "iso3",   :limit => 3
    t.string  "nombre", :limit => 80
  end

  create_table "pictures", :force => true do |t|
    t.string   "image"
    t.integer  "artist_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.text     "title",                                                     :null => false
    t.text     "content",          :limit => 2147483647,                    :null => false
    t.datetime "published_at",                                              :null => false
    t.integer  "poster_id"
    t.boolean  "international",                          :default => false, :null => false
    t.string   "slug",             :limit => 200,                           :null => false
    t.integer  "last_editor_id"
    t.boolean  "draft",                                  :default => false, :null => false
    t.integer  "total_read_count",                       :default => 0,     :null => false
    t.integer  "week_read_count",                        :default => 0,     :null => false
    t.integer  "comments_count",                         :default => 0,     :null => false
    t.datetime "updated_at"
    t.boolean  "closed_comments",                        :default => false, :null => false
  end

  add_index "posts", ["last_editor_id"], :name => "FK_ULTIMO_EDITOR"
  add_index "posts", ["poster_id"], :name => "FK_POSTEADOR"
  add_index "posts", ["slug"], :name => "IDX_PERMALINK"
  add_index "posts", ["slug"], :name => "UNQ_PERMALINK", :unique => true

  create_table "provincia", :force => true do |t|
    t.string "nombre", :limit => 30, :null => false
  end

  create_table "publicidad", :primary_key => "seccion", :force => true do |t|
    t.text "codigo"
  end

  create_table "punchlines", :force => true do |t|
    t.integer  "album_id",                          :null => false
    t.text     "description"
    t.datetime "published_at"
    t.boolean  "online",         :default => false, :null => false
    t.text     "lead_in",                           :null => false
    t.integer  "downloads",      :default => 0
    t.datetime "created_at"
    t.boolean  "featured",       :default => false
    t.string   "slug"
    t.string   "package"
    t.string   "package_job_id"
  end

  add_index "punchlines", ["album_id"], :name => "id_disco"
  add_index "punchlines", ["slug"], :name => "index_punchlines_on_slug", :unique => true

  create_table "record_labels", :force => true do |t|
    t.text    "name",                                                   :null => false
    t.boolean "international",                       :default => false, :null => false
    t.text    "web"
    t.text    "email"
    t.text    "phone"
    t.text    "address"
    t.string  "slug",          :limit => 200
    t.text    "info",          :limit => 2147483647,                    :null => false
    t.string  "twitter"
    t.string  "logo"
  end

  add_index "record_labels", ["slug"], :name => "UNQ_PERMALINK_SELLO", :unique => true

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "score_lyrics"
    t.integer  "score_production"
    t.integer  "score_collaborations"
    t.integer  "score_artwork"
    t.integer  "votes",                :default => 0
    t.integer  "author_id"
    t.integer  "album_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "song_files", :force => true do |t|
    t.integer "song_id"
    t.integer "downloads",    :default => 0
    t.integer "plays",        :default => 0
    t.text    "audio",                       :null => false
    t.integer "punchline_id"
  end

  add_index "song_files", ["punchline_id"], :name => "id_punchline"
  add_index "song_files", ["song_id"], :name => "id_cancion"

  create_table "song_likes", :id => false, :force => true do |t|
    t.integer "user_id", :limit => 3, :null => false
    t.integer "song_id",              :null => false
  end

  add_index "song_likes", ["song_id"], :name => "FK_UCF_CANCION"
  add_index "song_likes", ["user_id", "song_id"], :name => "index_song_likes_on_user_id_and_song_id"

  create_table "songs", :force => true do |t|
    t.text     "title",                                                              :null => false
    t.text     "lyrics",                    :limit => 2147483647
    t.datetime "lyrics_date"
    t.integer  "lyrics_sender_id",          :limit => 3
    t.integer  "lyrics_last_reviser_id",    :limit => 3
    t.text     "video_link"
    t.text     "video_embed_code"
    t.integer  "artist_id",                                                          :null => false
    t.datetime "video_date"
    t.datetime "lyrics_last_revision_date"
    t.integer  "lyrics_validator_id"
    t.boolean  "unreleased",                                      :default => false, :null => false
    t.integer  "video_sender_id",           :limit => 3
    t.integer  "video_validator_id"
    t.string   "slug",                                                               :null => false
    t.integer  "fav_count",                                       :default => 0,     :null => false
    t.string   "audio_link"
  end

  add_index "songs", ["artist_id"], :name => "FK_CANCION2AUTOR"
  add_index "songs", ["lyrics_last_reviser_id"], :name => "FK_CANCION2CORRECTORLETRA"
  add_index "songs", ["lyrics_sender_id"], :name => "FK_CANCION2ENVIADORLETRA"
  add_index "songs", ["lyrics_validator_id"], :name => "FK_CANCION2VALIDADORLETRA"
  add_index "songs", ["slug"], :name => "IDX_PERMALINK_CANCION", :unique => true
  add_index "songs", ["video_sender_id"], :name => "FK_CANCION2ENVIADORVIDEO"
  add_index "songs", ["video_validator_id"], :name => "FK_CANCION2VALIDADORVIDEO"

  create_table "sorteo", :force => true do |t|
    t.text    "titulo", :null => false
    t.integer "orden",  :null => false
    t.text    "enlace", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "taggable_id",                       :null => false
    t.integer  "tag_id",                            :null => false
    t.string   "taggable_type", :default => "Post"
    t.datetime "created_at"
    t.integer  "tagger_id"
    t.string   "context",       :default => "tags"
    t.string   "tagger_type"
  end

  add_index "taggings", ["tag_id"], :name => "FK_tag_noticia2tag"
  add_index "taggings", ["taggable_id"], :name => "FK_tag_noticia2noticia"
  add_index "taggings", ["taggable_type"], :name => "index_taggings_on_taggable_type_and_context"
  add_index "taggings", ["tagger_id"], :name => "index_taggings_on_tagger_id"

  create_table "tags", :force => true do |t|
    t.string "name", :null => false
    t.string "slug", :null => false
  end

  add_index "tags", ["name"], :name => "UNQ_IDX_TAGS", :unique => true
  add_index "tags", ["slug"], :name => "UNQ_IDX_TPERMALINK", :unique => true

  create_table "task_logs", :force => true do |t|
    t.string   "purpose"
    t.text     "stdout"
    t.text     "stderr"
    t.datetime "created_at"
  end

  create_table "tracks", :force => true do |t|
    t.integer "album_id",     :null => false
    t.integer "song_id",      :null => false
    t.integer "track_number"
  end

  add_index "tracks", ["song_id"], :name => "FK_TRACKLIST2CANCION"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => ""
    t.string   "displayname",                               :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  :default => false
    t.boolean  "staff",                  :default => false
    t.integer  "old_forum_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.integer  "comments_count",         :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "usuario_amigo", :id => false, :force => true do |t|
    t.integer "id_usuario", :limit => 3, :null => false
    t.integer "id_amigo",   :limit => 3, :null => false
  end

  add_index "usuario_amigo", ["id_amigo"], :name => "FK_USAM_AMIGO"

  create_table "usuario_data", :force => true do |t|
  end

  create_table "usuario_visita", :id => false, :force => true do |t|
    t.integer  "id_usuario",   :null => false
    t.integer  "id_visitante", :null => false
    t.datetime "fecha_hora",   :null => false
  end

  add_index "usuario_visita", ["id_usuario"], :name => "FK_USUARIO_VISITADO"
  add_index "usuario_visita", ["id_visitante"], :name => "FK_USUARIO_VISITANTE"

  create_table "videoclip_sin_validar", :id => false, :force => true do |t|
    t.integer  "id_enviador",  :limit => 3, :null => false
    t.integer  "id_cancion",                :null => false
    t.text     "cod_embebido"
    t.text     "enlace_video"
    t.datetime "fecha_envio",               :null => false
  end

  add_index "videoclip_sin_validar", ["id_cancion"], :name => "FK_VCSV2CANCION"

end
