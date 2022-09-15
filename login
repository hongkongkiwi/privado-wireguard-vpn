#!/bin/bash -ue
CREDS_FILE="${CREDS_FILE:-"creds.env"}"
source "$CREDS_FILE" ||{ echo >&2 "ERROR: invalid creds $CREDS_FILE file!"; exit 255; }
CLIENT_API_URL="${CLIENT_API_URL:-"https://client-api.privado.io/v1"}"
LOGIN_TOKEN_FILE="${LOGIN_TOKEN:-"data/token.json"}"
USER_AGENT="${USER_AGENT:-"App: 3.0.0 (576942783), macOS: Version 12.4 (Build 21F79)"}"
mkdir -p "$(dirname "$LOGIN_TOKEN_FILE")"

curl "$CLIENT_API_URL/login" \
--compressed --silent \
-X POST \
-H "$USER_AGENT" \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Content-Type: application/json' \
-d '{
  "api_key" : "'$API_KEY'",
  "password" : "'$PASSWORD'",
  "username" : "'$USERNAME'"
}' | jq | sponge "$LOGIN_TOKEN_FILE" \
&& echo "Successfully logged in" \
|| echo >&2 "ERROR: failed to login"
