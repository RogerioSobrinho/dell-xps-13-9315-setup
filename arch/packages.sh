#!/bin/bash
set -eu
function init_config() {
    local COMMONS_FILE="commons.sh"

    source "$COMMONS_FILE"
    source "$PACKAGES_CONF_FILE"
}

function sanitize_variables() {
    PACKAGES_PACMAN=$(sanitize_variable "$PACKAGES_PACMAN")
    PACKAGES_FLATPAK=$(sanitize_variable "$PACKAGES_FLATPAK")
    PACKAGES_AUR_COMMAND=$(sanitize_variable "$PACKAGES_AUR_COMMAND")
    PACKAGES_AUR=$(sanitize_variable "$PACKAGES_AUR")
    SYSTEMD_UNITS=$(sanitize_variable "$SYSTEMD_UNITS")
}

function packages() {
    print_step 'packages()'

    packages_pacman
    packages_flatpak
    packages_aur
}

function packages_pacman() {
    print_step 'packages_pacman()'

    if [ "$PACKAGES_PACMAN_INSTALL" == 'true' ]; then
        if [ -n "$PACKAGES_PACMAN" ]; then
            pacman_install "$PACKAGES_PACMAN"
        fi
    fi
}

function packages_flatpak() {
    print_step 'packages_flatpak()'

    if [ "$PACKAGES_FLATPAK_INSTALL" == 'true' ]; then
        pacman_install 'flatpak'

        if [ -n "$PACKAGES_FLATPAK" ]; then
            flatpak_install "$PACKAGES_FLATPAK"
        fi
    fi
}

function packages_aur() {
    print_step 'packages_aur()'

    if [ "$PACKAGES_AUR_INSTALL" == 'true' ]; then
        IFS=' ' local COMMANDS=($PACKAGES_AUR_COMMAND)
        aur_command_install "rogerio" "$COMMANDS"
        AUR_COMMAND="${COMMANDS}"
        if [ -n "$PACKAGES_AUR" ]; then
            aur_install "$PACKAGES_AUR"
        fi
    fi
}

function systemd_units() {
    IFS=' ' local UNITS=($SYSTEMD_UNITS)
    for U in ${UNITS[@]}; do
        local ACTION=""
        local UNIT=${U}
        if [[ $UNIT == -* ]]; then
            local ACTION='disable'
            local UNIT=$(echo $UNIT | sed "s/^-//g")
        elif [[ $UNIT == +* ]]; then
            local ACTION='enable'
            local UNIT=$(echo $UNIT | sed "s/^+//g")
        elif [[ $UNIT =~ ^[a-zA-Z0-9]+ ]]; then
            local ACTION='enable'
            local UNIT=$UNIT
        fi

        if [ -n "$ACTION" ]; then
            execute_sudo "systemctl $ACTION $UNIT"
        fi
    done
}

function end() {
    echo ''
    echo -e "${GREEN} Arch Linux packages installed successfully"'!'"${NC}"
    echo ''
}

function main() {
    local START_TIMESTAMP=$(date -u +"%F %T")
    init_config
    execute_step "sanitize_variables"
    execute_step "init"
    execute_step "packages"
    execute_step "systemd_units"
    local END_TIMESTAMP=$(date -u +"%F %T")
    local INSTALLATION_TIME=$(date -u -d @$(($(date -d "$END_TIMESTAMP" '+%s') - $(date -d "$START_TIMESTAMP" '+%s'))) '+%T')
    echo -e "Installation packages start ${WHITE}$START_TIMESTAMP${NC}, end ${WHITE}$END_TIMESTAMP${NC}, time ${WHITE}$INSTALLATION_TIME${NC}"
    execute_step "end"
}

main $@
