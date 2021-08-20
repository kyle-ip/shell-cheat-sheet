#!/usr/bin/env bash

# Reference
# pure bash bible: https://github.com/dylanaraps/pure-bash-bible

#######################################
# Trim leading and trailing white-space from string
# Globals:
# Arguments: string
# Outputs: string
# Returns: 
#######################################
trim() {
    # Usage: trim "    Hello,  World    "
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

#######################################
# Trim all white-space from string and truncate spaces
# Globals:
# Arguments: string
# Outputs: string
# Returns: 
#######################################
# shellcheck disable=SC2086,SC2048
trim_all() {
    # Usage: trim_all "    Hello,    World    "
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}

#######################################
# Use regex on a string
# Globals:
# Arguments: string
# Outputs: string
# Returns: 
#######################################
regex() {
    # Usage: regex '    hello' '^\s*(.*)'
    [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

#######################################
# Split a string on a delimiter
# Globals:
# Arguments: string
# Outputs: array
# Returns: 
#######################################
split() {
   # Usage: split "apples,oranges,pears,grapes" ","
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

split() {
    str=$1
    delimiter=$2
    arr=(${str//$2/ })

    # echo ${arr[1]}  
    printf '%s\n' "${arr[@]}"
}

#######################################
# Change a string to lowercase
# Globals:
# Arguments: string
# Outputs:
# Returns: string
#######################################
lower() {
    # Usage: lower "string"
    # printf '%s\n' "${1,,}"
    echo "$1" | tr '[:upper:]' '[:lower:]'
    return "$1" | tr '[:upper:]' '[:lower:]'
}

#######################################
# Change a string to uppercase
# Globals:
# Arguments: string
# Outputs:
# Returns: string
#######################################
upper() {
    # Usage: lower "string"
    # printf '%s\n' "${1,,}"
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

#######################################
# Reverse a string 
# Globals:
# Arguments: string
# Outputs: string
# Returns: 
#######################################
reverse() {
    # Usage: reverse_case "string"
    echo $1 | rev
}

#######################################
# Reverse a string 
# Globals:
# Arguments: string
# Outputs: string
# Returns: 
#######################################
trim_quotes() {
    # Usage: trim_quotes "string"
    : "${1//\'}"
    printf '%s\n' "${_//\"}"
}

#######################################
# Replace a string with xxx
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
replace_all() {
    echo $1 | sed "s/$2/$3/g"
}

#######################################
# Strip all instances of pattern from string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
strip_all() {
    # Usage: strip_all "string" "pattern"
    # printf '%s\n' "${1//$2}"
    echo $1 | sed "s/$2//g"
}

#######################################
# Strip first occurrence of pattern from string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
strip() {
    # Usage: strip "string" "pattern"
    echo $1 | sed "s/$2//"
}

#######################################
# Strip pattern from start of string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
lstrip() {
    # Usage: strip "string" "pattern"
    echo $1 | sed "s/^$2//"
}

#######################################
# Strip pattern from end of string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
rstrip() {
    # Usage: strip "string" "pattern"
    echo $1 | sed "s/$2$//"
}

#######################################
# Percent-encode a string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
urlencode() {
    # Usage: urlencode "string"
    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9.~_-])
                printf '%s' "$_"
            ;;

            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

#######################################
# Decode a percent-encoded string
# Globals:
# Arguments: string
# Outputs: string
# Returns:
#######################################
urldecode() {
    # Usage: urldecode "string"
    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}

#######################################
# Check if string contains a sub-string
# Globals:
# Arguments: string
# Outputs:
# Returns:
#######################################
contains() {
    if [[ $1 == *$2* ]]; then
        return 0
    fi
    return 1
}

#######################################
# Check if string starts with sub-string
# Globals:
# Arguments: string
# Outputs:
# Returns:
#######################################
starts_with() {
    if [[ $1 == $2* ]]; then
        return 0
    fi
    return 1
}

#######################################
# Check if string ends with sub-string
# Globals:
# Arguments: string
# Outputs:
# Returns:
#######################################
ends_with() {
    if [[ $1 == *$2 ]]; then
        return 0
    fi
    return 1
}

#######################################
# Reverse an array
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
reverse_array() {
    # Usage: reverse_array "array"
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

#######################################
# Remove duplicate array elements
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
remove_array_dups() {
    # Usage: remove_array_dups "array"
    declare -A tmp_array
    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done
    printf '%s\n' "${!tmp_array[@]}"
}

#######################################
# Random array element
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
random_array_element() {
    # Usage: random_array_element "array"
    local arr=("$@")
    printf '%s\n' "${arr[RANDOM % $#]}"
}

#######################################
# Cycle through an array
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
cycle() {
    local arr=("$@")
    printf '%s ' "${arr[${i:=0}]}"
    ((i=i>=${#arr[@]}-1?0:++i))
}

#######################################
# Toggle between two values
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
cycle() {
    arr=(true false)
    printf '%s ' "${arr[${i:=0}]}"
    ((i=i>=${#arr[@]}-1?0:++i))
}

#######################################
# Get a range of numbers
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
range() {
    if [ $# -eq 1 ];
    then
        for element in "${arr[@]}"; do
            printf '%s\n' "$element"
        done
        return 0
    fi
    for ((i=$1;i<=$2;i++)); do
        printf '%s\n' "$i"
    done
}

#######################################
# Generate a UUID V4
# Globals:
# Arguments: array
# Outputs:
# Returns: array
#######################################
uuid() {
    # Usage: uuid
    C="89ab"

    for ((N=0;N<16;++N)); do
        B="$((RANDOM%256))"

        case "$N" in
            6)  printf '4%x' "$((B%16))" ;;
            8)  printf '%c%x' "${C:$RANDOM%${#C}:1}" "$((B%16))" ;;

            3|5|7|9)
                printf '%02x-' "$B"
            ;;

            *)
                printf '%02x' "$B"
            ;;
        esac
    done

    printf '\n'
}

#######################################
# Progress bars
# Globals:
# Arguments: 
# Outputs:
# Returns: 
#######################################
progress_bar() {
    # Usage: bar 1 10
    #            ^----- Elapsed Percentage (0-100).
    #               ^-- Total length in chars.
    ((elapsed=$1*$2/100))

    # Create the bar with spaces.
    printf -v prog  "%${elapsed}s"
    printf -v total "%$(($2-elapsed))s"

    printf '%s\r' "[${prog// /-}${total}]"

    # for ((i=0;i<=100;i++)); do
    #     # Pure bash micro sleeps (for the example).
    #     (:;:) && (:;:) && (:;:) && (:;:) && (:;:)
    # 
    #     # Print the bar.
    #     progress_bar "$i" "10"
    # done
    # printf '\n'
}


#######################################
# Get the list of functions in a script
# Globals:
# Arguments:
# Outputs:
# Returns: array
#######################################
get_functions() {
    # Usage: get_functions
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '%s\n' "${functions[@]//declare -f }"
}

#######################################
# Assertion for unittest
# Globals:
# Arguments:
# Outputs:
# Returns: array
#######################################
assert_equals() {
    if [[ "$1" == "$2" ]]; then
        ((pass+=1))
        status=$'\e[32m✔'
    else
        ((fail+=1))
        status=$'\e[31m✖'
        local err="(\"$1\" != \"$2\")"
    fi

    printf ' %s\e[m | %s\n' "$status" "${FUNCNAME[1]/test_} $err"
}

# Capture the return value of a function without command substitution: 
# 
# to_upper() {
#   local -n ptr=${1}
# 
#   ptr=${ptr^^}
# }
# 
# foo="bar"
# to_upper foo