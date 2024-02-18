TRAIN_STATION_URL="https://data.sncf.com/api/explore/v2.1/catalog/datasets/referentiel-gares-voyageurs/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B"
TRAIN_STATION_FILE=referentiel-gares-voyageurs
TRAIN_STATION_CSV_HEADERS=train_station_code;name;fronton_name;postal_code;city_code;city_name;county_code;county_name;uic_code;longitude;latitude;sncf_region;unity_gare;drg_segment;plateform_code;plateform_name;rg;plateform_count;inserted_at;updated_at
TRAIN_STATION_CSV_HEADERS_INSERT:=$(shell echo "${TRAIN_STATION_CSV_HEADERS}" | sed --expression='s/;/,/g')
TRAIN_STATION_TABLE_NAME=train_stations

download-deps:
	mkdir -p data

# 1               ; 2       ; 3      ; 4                          ; 5                 ; 6         ; 7          ; 8     ; 9              ; 10        ; 11       ; 12    ; 13        ; 14              ;15;  16         ; 17                     ; 18; 19        ; 20       ;21; 22             ; 23; 24
# Code plate-forme;Code gare;Code UIC;Date fin validité plateforme;Intitulé plateforme;Code postal;Code Commune;Commune;Code département;Département;Longitude;Latitude;Segment DRG;Niveau de service;RG;Intitulé gare;Intitulé fronton de gare;DTG;Région SNCF;Unité gare;UT;Nbre plateformes;TVS;WGS 84
download-train-stations-data: 
	curl ${TRAIN_STATION_URL} | awk 'NR>1' > data/${TRAIN_STATION_FILE}_raw.csv
	cat data/${TRAIN_STATION_FILE}_raw.csv | awk -F';' -v date="$$(date +'%Y-%m-%d')" 'BEGIN { OFS = ";"}{ print $$2, $$16, $$17, $$6, $$7, $$8, $$9, $$10, $$3, $$11, $$12, $$19, $$20, $$13, $$1, $$5, $$15, $$22, date, date}' > data/${TRAIN_STATION_FILE}.csv
	sed -i -r '1s/^/${TRAIN_STATION_CSV_HEADERS}\n/' data/${TRAIN_STATION_FILE}.csv

download-data: download-deps download-train-stations-data

setup-postgresql:
	docker compose up -d

# connect to psql
#	psql postgresql://username:password@localhost:5432/sncf

DATABASE_NAME=default_database
PSQL_AUTH=postgresql://username:password@localhost:5432

load-data: download-data 
	echo ${TRAIN_STATION_CSV_HEADERS_INSERT}
	psql ${PSQL_AUTH}/${DATABASE_NAME} -c "\copy ${TRAIN_STATION_TABLE_NAME}(${TRAIN_STATION_CSV_HEADERS_INSERT}) FROM 'data/${TRAIN_STATION_FILE}.csv' delimiter ';' csv header"

# === elixir ===
# Then configure your database in config/dev.exs and run:
elixir-ecto-create:
	sleep 2
	mix ecto.create
	mix ecto.migrate

first-install: setup-postgresql elixir-ecto-create load-data

phoenix-start-server:
	mix phx.server

phoenix-start-server-iex:
	iex -S mix phx.server

