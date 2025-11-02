#!/command/with-contenv bashio
# shellcheck shell=bash

# Set timezone
if bashio::config.has_value 'timezone'; then
    TIMEZONE=$(bashio::config 'timezone')
    bashio::log.info "Setting timezone to ${TIMEZONE}"
    ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
    echo "${TIMEZONE}" > /etc/timezone
else
    bashio::log.info "Using default timezone UTC"
fi