#!/bin/bash -ue
CREDS_FILE="${CREDS_FILE:-"creds.env"}"
[ -f "$CREDS_FILE" ] && source "$CREDS_FILE"
[ -n "$PRIVADO_USERNAME" ] || { echo >&2 "ERROR: PRIVADO_USERNAME not set or missing creds file; exit 255; }
[ -n "$PRIVADO_PASSWORD" ] || { echo >&2 "ERROR: PRIVADO_PASSWORD not set or missing creds file; exit 255; }
API_KEY="${API_KEY:-"9f994c466340e8f2ed60a99396fecb6a"}"
CLIENT_API_URL="${CLIENT_API_URL:-"https://client-api.privado.io/v1"}"
LOGIN_TOKEN_FILE="${LOGIN_TOKEN:-"data/token.json"}"
USER_AGENT="${USER_AGENT:-"App: 3.0.0 (576942783), macOS: Version 12.4 (Build 21F79)"}"
mkdir -p "$(dirname "$LOGIN_TOKEN_FILE")"

curl "$CLIENT_API_URL/login" \
--compressed --silent \
-X POST \
-H "User-Agent: $USER_AGENT" \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Content-Type: application/json' \
-d '{
  "api_key" : "'$API_KEY'",
  "password" : "'$PRIVADO_PASSWORD'",
  "username" : "'$PRIVADO_USERNAME'"
}' | jq > "$LOGIN_TOKEN_FILE" \
&& echo "Successfully logged in" \
|| echo >&2 "ERROR: failed to login"