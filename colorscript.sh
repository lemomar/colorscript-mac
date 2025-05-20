#!/usr/bin/env bash

# Simple CLI for shell-color-scripts

DIR_COLORSCRIPTS="/opt/shell-color-scripts/colorscripts"
fmt_help="  %-20s\t%-54s\n"

# Find ls command
if [ -x "/bin/ls" ]; then
    LS_CMD="/bin/ls"
elif [ -x "/usr/bin/ls" ]; then
    LS_CMD="/usr/bin/ls"
else
    echo "Error: Could not find ls command"
    exit 1
fi

# Get list of scripts and count
if [ -d "${DIR_COLORSCRIPTS}" ]; then
    list_colorscripts="$(${LS_CMD} "${DIR_COLORSCRIPTS}" | cut -d ' ' -f 1 | nl)"
    length_colorscripts="$(${LS_CMD} "${DIR_COLORSCRIPTS}" | wc -l)"
else
    echo "Error: Color scripts directory not found"
    exit 1
fi

function _help() {
    echo "Description: A collection of terminal color scripts."
    echo ""
    echo "Usage: colorscript [OPTION] [SCRIPT NAME/INDEX]"
    printf "${fmt_help}" \
        "-h, --help, help" "Print this help." \
        "-l, --list, list" "List all installed color scripts." \
        "-r, --random, random" "Run a random color script." \
        "-e, --exec, exec" "Run a specified color script by SCRIPT NAME or INDEX."
}

function _list() {
    echo "There are ${length_colorscripts} installed color scripts:"
    echo "${list_colorscripts}"
}

function _random() {
    if [ "$length_colorscripts" -gt 0 ]; then
        declare -i random_index=$(($RANDOM % $length_colorscripts + 1))
        random_colorscript="$(echo "${list_colorscripts}" | sed -n ${random_index}p \
            | tr -d ' ' | tr '\t' ' ' | cut -d ' ' -f 2)"
        if [ -n "$random_colorscript" ]; then
            exec "${DIR_COLORSCRIPTS}/${random_colorscript}"
        else
            echo "Error: Could not select random script"
            exit 1
        fi
    else
        echo "Error: No color scripts found"
        exit 1
    fi
}

function ifhascolorscipt() {
    [[ -e "${DIR_COLORSCRIPTS}/$1" ]] && echo "Has this color script."
}

function _run_by_name() {
    if [[ "$1" == "random" ]]; then
        _random
    elif [[ -n "$(ifhascolorscipt "$1")" ]]; then
        exec "${DIR_COLORSCRIPTS}/$1"
    else
        echo "Input error, Don't have color script named $1."
        exit 1
    fi
}

function _run_by_index() {
    if [[ "$1" -gt 0 && "$1" -le "${length_colorscripts}" ]]; then
        colorscript="$(echo "${list_colorscripts}" | sed -n ${1}p \
            | tr -d ' ' | tr '\t' ' ' | cut -d ' ' -f 2)"
        if [ -n "$colorscript" ]; then
            exec "${DIR_COLORSCRIPTS}/${colorscript}"
        else
            echo "Error: Could not find script at index $1"
            exit 1
        fi
    else
        echo "Input error, Don't have color script indexed $1."
        exit 1
    fi
}

case "$1" in
    -h|--help|help)
        _help
        ;;
    -l|--list|list)
        _list
        ;;
    -r|--random|random)
        _random
        ;;
    -e|--exec|exec)
        [[ -z "$2" ]] && echo "Input error, see help." && exit 1
        if [[ "$2" =~ ^[0-9]+$ ]]; then
            _run_by_index "$2"
        else
            _run_by_name "$2"
        fi
        ;;
    *)
        echo "Input error, see help." && exit 1
        ;;
esac
