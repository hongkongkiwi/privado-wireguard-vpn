#!/bin/bash -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PRIVADO_USERNAME="${PRIVADO_USERNAME:-""}"
PRIVADO_PASSWORD="${PRIVADO_PASSWORD:-""}"
PRIVADO_VPN_SERVERS="${PRIVADO_VPN_SERVERS:-""}"
WIREGUARD_CONF_STARTING_NUM="${WIREGUARD_CONF_STARTING_NUM:-"0"}"
WIREGUARD_FILE_OUTPUT_DIR="${WIREGUARD_FILE_OUTPUT_DIR:-"/config"}"
ORIG_CONTAINER_INIT="/init"
LOG_PREFIX="Privado VPN: "

if ! command -v envsubst >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  echo "${LOG_PREFIX}Installing envsubst package ..."
  apt-get update -qq && apt-get -qq -y install "gettext-base"
fi

if [ -n "$PRIVADO_VPN_SERVERS" ]; then
  COUNTER=$WIREGUARD_CONF_STARTING_NUM
  IFS=","; for PRIVADO_VPN_SERVER in $PRIVADO_VPN_SERVERS; do
    [ -d "$WIREGUARD_FILE_OUTPUT_DIR" ] || mkdir -p "$WIREGUARD_FILE_OUTPUT_DIR"
    bash "$SCRIPT_DIR/wireguard_conf_start_to_finish" "$PRIVADO_VPN_SERVER" "$WIREGUARD_FILE_OUTPUT_DIR/wg$COUNTER.conf"
    COUNTER=$((COUNTER+1))
  done
else
  echo >&2 "${LOG_PREFIX}NOTE: PRIVADO_VPN_SERVERS is empty skipping wireguard config generation"
fi

# Run our origional container init
exec "$ORIG_CONTAINER_INIT" $@
