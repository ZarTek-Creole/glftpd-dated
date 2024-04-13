#!/bin/bash
#################################################################
#                                                               #
# Script by ZarTek-Creole, https://github.com/ZarTek-Creole     #
#                                                               #
#--[ Parameters ]-----------------------------------------------#

sections=()

# Path to glftpd root directory
GLROOT="/glftpd"

# Path to glftpd log file
GLOG="$GLROOT/ftp-data/logs/glftpd.log"

# Sections array in the format "source" "destination" "interval"
sections+=("INCOMING-US/FLAC" "!ThisDay_US-FLAC" "DAY")
sections+=("INCOMING-FR/FLAC" "!ThisMonth_FR-FLAC" "MONTH")
sections+=("INCOMING-US/0DAYS" "!ThisDay_US-0DAYS" "DAY")
sections+=("INCOMING-FR/EBOOK" "!ThisWeek_FR-EBOOK" "WEEK")
sections+=("INCOMING-CONSOLE/PS5" "!ThisYear_PS5" "YEAR")
sections+=("INCOMING-CONSOLE/PS4" "!ThisYear_PS4" "YEAR")
sections+=("INCOMING-CONSOLE/NSW" "!ThisYear_NSW" "YEAR")
sections+=("INCOMING-FR/GAMES" "!ThisYear_FR_GAMES" "YEAR")
sections+=("INCOMING-US/GAMES" "!ThisYear_US_GAMES" "YEAR")
#sections+=("ARCHIVE/EBOOK" "!ThisYear_ARCHIVE-EBOOK" "YEAR")


root_link="_root"
root_source="../../../"

# Verifies the existence of critical directories and files
check_requirements() {
    if [[ ! -d "$GLROOT" || ! -f "$GLOG" ]]; then
        echo "Error: Either $GLROOT or $GLOG does not exist."
        exit 1
    fi
}

# Creates a directory with appropriate permissions
create_directory() {
    local source_section="$1"
    local new_date="$2"

    chmod -R 755 "$GLROOT/site/$source_section"
    mkdir -p -m 777 "$GLROOT/site/$source_section/$new_date"
    echo "(cd $GLROOT/site/$source_section/$new_date && ln -s $root_source $root_link)"
    (cd "$GLROOT/site/$source_section/$new_date" && ln -s "$root_source" "$root_link")
}

# Creates or updates a symbolic link
create_symbolic_link() {
    local source_section="$1"
    local new_date="$2"
    local dest_section="$3"

    local link_path="$GLROOT/site/$dest_section"
    [[ -L "$link_path" ]] && unlink "$link_path"

    (cd "$GLROOT/site" && ln -s "./$source_section/$new_date" "$dest_section")
}

# Logs a message to the GLFTPD log
log_action() {
    local message="$1"
    echo "$(date "+%a %b %e %T %Y") ZARTEK-DATED: $message" >> "$GLOG"
}

# Processes each section based on its configuration
process_section() {
    local source_section="$1"
    local dest_section="$2"
    local interval="$3"

    local new_date
    case $interval in
        DAY) new_date=$(date +%Y-%m-%d);;
        WEEK) new_date=$(date +%Y-%U);;
        MONTH) new_date=$(date +%Y-%m);;
        YEAR) new_date=$(date +%Y);;
        *) echo "Error: Invalid interval $interval for $source_section"; exit 1;;
    esac

    if [[ ! -d "$GLROOT/site/$source_section/$new_date" ]]; then
        create_directory "$source_section" "$new_date"
        create_symbolic_link "$source_section" "$new_date" "$dest_section"
        log_action "\"$source_section\" \"$new_date\" \"$interval\""
    fi
}

main() {
    check_requirements
    for ((i=0; i<${#sections[@]}; i+=3)); do
        process_section "${sections[i]}" "${sections[i+1]}" "${sections[i+2]}"
    done
}

main
