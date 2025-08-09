#!/usr/bin/env bash

set -Eeuo pipefail

process_sql () {
	psql -v ON_ERROR_STOP --no-psqlrc --tuples-only "$@"
}

create_user () {
	if [[ "$#" -ne 2 ]]; then
		echo "USAGE: $0 username password" >&2
		return 1
	fi

	local username="$1"
	local password="$2"
	local user_exists
	user_exists="$(
		process_sql -v username="$username" <<-'EOF'
			SELECT 1 FROM pg_user WHERE usename = :'username' ;
		EOF
	)"

	if [[ -z "$user_exists" ]]; then
		process_sql -v username="$username" -v password="$password" <<-'EOF'
			CREATE ROLE :"username" WITH LOGIN PASSWORD :'password' ;
		EOF
	else
		process_sql -v username="$username" -v password="$password" <<-'EOF'
			ALTER ROLE :"username" WITH LOGIN PASSWORD :'password' ;
		EOF
	fi

	local db_exists
	db_exists="$(
		process_sql -v db="$username" <<-'EOF'
			SELECT 1 FROM pg_database WHERE datname = :'db' ;
		EOF
	)"

	if [[ -z "$db_exists" ]]; then
		process_sql -v db="$username" <<-'EOF'
			CREATE DATABASE :"db" WITH OWNER :"db" ;
		EOF
	fi
}

create_user authentik "$AUTHENTIK_POSTGRESQL_PASSWORD"
create_user pangolin "$PANGOLIN_POSTGRESQL_PASSWORD"
