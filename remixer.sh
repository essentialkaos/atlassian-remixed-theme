#!/usr/bin/env bash

################################################################################

NORM=0
BOLD=1
UNLN=4
RED=31
GREEN=32
YELLOW=33
BLUE=34
MAG=35
CYAN=36
GREY=37
DARK=90

CL_NORM="\e[0m"
CL_BOLD="\e[0;${BOLD};49m"
CL_UNLN="\e[0;${UNLN};49m"
CL_RED="\e[0;${RED};49m"
CL_GREEN="\e[0;${GREEN};49m"
CL_YELLOW="\e[0;${YELLOW};49m"
CL_BLUE="\e[0;${BLUE};49m"
CL_MAG="\e[0;${MAG};49m"
CL_CYAN="\e[0;${CYAN};49m"
CL_GREY="\e[0;${GREY};49m"
CL_DARK="\e[0;${DARK};49m"
CL_BL_RED="\e[1;${RED};49m"
CL_BL_GREEN="\e[1;${GREEN};49m"
CL_BL_YELLOW="\e[1;${YELLOW};49m"
CL_BL_BLUE="\e[1;${BLUE};49m"
CL_BL_MAG="\e[1;${MAG};49m"
CL_BL_CYAN="\e[1;${CYAN};49m"
CL_BL_GREY="\e[1;${GREY};49m"

################################################################################

AVATARS_DIR="/srv/jira-data/data/avatars"

DB_USER="jira"
DB_NAME="jiradb"

################################################################################

main() {
  local db_pass="$1"
  local target_type="$2"

  if [[ -z "$db_pass" ]] ; then
    show "${CL_BOLD}Usage:${CL_NORM} ./remixer.sh ${CL_GREY}{db-pass}${CL_NORM} ${CL_DARK}{type-name}${CL_NORM}"
    exit 0
  fi

  checkReq
  updateIcons "$db_pass" "$target_type"

  exit $?
}

################################################################################

# Check for required apps
#
# Code: No
# Echo: No
checkReq() {
  if ! type -P psql &> /dev/null ; then
    error "psql is required"
    exit 1
  fi

  if [[ ! -d "$AVATARS_DIR" ]] ; then
    error "There is no directory $AVATARS_DIR"
    exit 1
  fi
}

# Update icons for all supported issue types
#
# 1: DB password (String)
# 2: Target type name (String) [Optional]
#
# Code: No
# Echo: No
updateIcons() {
  local db_pass="$1"
  local target_type="$2"

  local id name type avatar uuid line tmp_file

  tmp_file=$(mktemp)
  PGPASSWORD="$db_pass" psql -U "$DB_USER" -d "$DB_NAME" -tA -c "SELECT avatar.id,pname,filename FROM avatar INNER JOIN issuetype ON avatar.id = issuetype.avatar WHERE avatar.avatartype = 'issuetype' AND avatar.systemavatar = 0;" 1> "$tmp_file"

  if [[ ! -s "$tmp_file" ]] ; then
    error "Can't get issue types info from DB"
    rm -f "$tmp_file"
    return 1
  fi

  show ""

  while IFS= read -r line ; do
    IFS="|" read -r id name avatar <<< "$line"

    type="${name,,}"
    type="${type//-/_}"
    type="${type// /_}"
    type="${type//\*/sub_}"
    uuid="${avatar%.*}"

    if [[ -n "$target_type" && "${name,,}" != "${target_type,,}" ]] ; then
      continue
    fi

    if [[ ! -f "icons/issue/2048/${type}.png" ]] ; then
      continue
    fi

    if [[ ! -f "$AVATARS_DIR/${id}_${uuid}.png" ]] ; then
      continue
    fi

    if copyIcons "$type" "$id" "$uuid" ; then
      show "${CL_GREEN}✔  ${CL_NORM}${CL_BOLD}${name}${CL_NORM} ${CL_DARK}($id)${CL_NORM}"
    else
      show "${CL_RED}✖  ${CL_NORM}${CL_BOLD}${name}${CL_NORM} ${CL_DARK}($id)${CL_NORM}"
    fi

  done < "$tmp_file"

  show ""

  rm -f "$tmp_file"

  return 0
}

# Copy issue type avatars for given type
#
# 1: Issue type name (String)
# 2: Avatar ID (Number)
# 3: Avatar UUID (String)
#
# Code: No
# Echo: No
copyIcons() {
  local name="$1"
  local id="$2"
  local uuid="$3"

  local size sizes
  sizes=("xsmall" "small" "small@3x" "medium" "large@3x" "xlarge" "xxlarge" "xxlarge@2x" "xxlarge@3x" "xxxlarge" "xxxlarge@2x" "xxxlarge@3x")

  if ! copyIcon "$name" "$id" "$uuid" "" ; then
    return 1
  fi

  for size in "${sizes[@]}" ; do
    if ! copyIcon "$name" "$id" "$uuid" "$size" ; then
      return 1
    fi
  done

  return 0
}

# Resize avatar to different sizes
#
# 1: Issue type name (String)
# 2: Avatar ID (Number)
# 3: Avatar UUID (String)
# 4: Size name (String) [Optional]
#
# Code: No
# Echo: No
copyIcon() {
  local name="$1"
  local id="$2"
  local uuid="$3"
  local size="$4"

  local wh output

  case $size in
    "")            wh="96"   ;;
    "xsmall")      wh="32"   ;;
    "small")       wh="48"   ;;
    "small@3x")    wh="144"  ;;
    "medium")      wh="64"   ;;
    "large@3x")    wh="288"  ;;
    "xlarge")      wh="128"  ;;
    "xxlarge")     wh="192"  ;;
    "xxxlarge")    wh="256"  ;;
    "xxlarge@2x")  wh="384"  ;;
    "xxlarge@3x")  wh="768"  ;;
    "xxxlarge@2x") wh="512"  ;;
    "xxxlarge@3x") wh="1024" ;;
  esac

  if [[ -z "$size" ]] ; then
    output="${id}_${uuid}.png"
  else
    output="${id}_${size}_${uuid}.png"
  fi

  cp --force \
     "icons/issue/${wh}/${name}.png" \
     "$AVATARS_DIR/$output"

  return $?
}

################################################################################

# Show message
#
# 1: Message (String)
# 2: Message color (Number) [Optional]
#
# Code: No
# Echo: No
show() {
  if [[ -n "$2" && -z "$no_colors" ]] ; then
    echo -e "\e[${2}m${1}\e[0m"
  else
    echo -e "$*"
  fi
}

# Print error message
#
# 1: Message (String)
# 2: Message color (Number) [Optional]
#
# Code: No
# Echo: No
error() {
  show "$@" $RED 1>&2
}

################################################################################

main "$@"
