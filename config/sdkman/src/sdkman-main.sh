#!/usr/bin/env bash

#
#   Copyright 2021 Marco Vermeulen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

function sdk() {

	COMMAND="$1"
	QUALIFIER="$2"

	case "$COMMAND" in
	l)
		COMMAND="list"
		;;
	ls)
		COMMAND="list"
		;;
	v)
		COMMAND="version"
		;;
	u)
		COMMAND="use"
		;;
	i)
		COMMAND="install"
		;;
	rm)
		COMMAND="uninstall"
		;;
	c)
		COMMAND="current"
		;;
	ug)
		COMMAND="upgrade"
		;;
	d)
		COMMAND="default"
		;;
	b)
		COMMAND="broadcast"
		;;
	h)
		COMMAND="home"
		;;
	e)
		COMMAND="env"
		;;
	esac

	if [[ "$COMMAND" == "home" ]]; then
		__sdk_home "$QUALIFIER" "$3"
		return $?
	fi

	# Left here for legacy purposes, issue #912 on Github
	if [[ "$COMMAND" == "completion" ]]; then
		return 0
	fi

	#
	# Various sanity checks and default settings
	#

	# Check candidates cache
	if [[ "$COMMAND" != "update" ]]; then
		___sdkman_check_candidates_cache "$SDKMAN_CANDIDATES_CACHE" || return 1
	fi
	# Check version cache
	___sdkman_check_version_cache

	# Always presume internet availability
	SDKMAN_AVAILABLE="true"
	if [ -z "$SDKMAN_OFFLINE_MODE" ]; then
		SDKMAN_OFFLINE_MODE="false"
	fi

	# ...unless proven otherwise
	__sdkman_update_broadcast_and_service_availability

	# Load the sdkman config if it exists.
	if [ -f "${SDKMAN_DIR}/etc/config" ]; then
		source "${SDKMAN_DIR}/etc/config"
	fi

	# no command provided
	if [[ -z "$COMMAND" ]]; then
		__sdk_help
		return 1
	fi

	# Check if it is a valid command
	CMD_FOUND=""
	if [[ "$COMMAND" != "selfupdate" || "$sdkman_selfupdate_feature" == "true" ]]; then
		CMD_TARGET="${SDKMAN_DIR}/src/sdkman-${COMMAND}.sh"
		if [[ -f "$CMD_TARGET" ]]; then
			CMD_FOUND="$CMD_TARGET"
		fi
	fi

	# Check if it is a sourced function
	CMD_TARGET="${SDKMAN_DIR}/ext/sdkman-${COMMAND}.sh"
	if [[ -f "$CMD_TARGET" ]]; then
		CMD_FOUND="$CMD_TARGET"
	fi

	# couldn't find the command
	if [[ -z "$CMD_FOUND" ]]; then
		echo ""
		__sdkman_echo_red "Invalid command: $COMMAND"
		echo ""
		__sdk_help
	fi

	# Check whether the candidate exists
	local sdkman_valid_candidate=$(echo ${SDKMAN_CANDIDATES[@]} | grep -w "$QUALIFIER")
	if [[ -n "$QUALIFIER" && "$COMMAND" != "help" && "$COMMAND" != "offline" && "$COMMAND" != "flush" && "$COMMAND" != "selfupdate" && "$COMMAND" != "env" && "$COMMAND" != "completion" && "$COMMAND" != "edit" && -z "$sdkman_valid_candidate" ]]; then
		echo ""
		__sdkman_echo_red "Stop! $QUALIFIER is not a valid candidate."
		return 1
	fi

	# Validate offline qualifier
	if [[ "$COMMAND" == "offline" && -n "$QUALIFIER" && -z $(echo "enable disable" | grep -w "$QUALIFIER") ]]; then
		echo ""
		__sdkman_echo_red "Stop! $QUALIFIER is not a valid offline mode."
	fi

	# Store the return code of the requested command
	local final_rc=0

	# Native commands found under libexec
	local native_command="${SDKMAN_DIR}/libexec/${COMMAND}"
	
	# Internal commands use underscores rather than hyphens
	local converted_command_name=$(echo "$COMMAND" | tr '-' '_')

	if [ -f "$native_command" ]; then
		# Available as native command
		if [ -z "$QUALIFIER" ]; then
			"$native_command"
		elif [ -z "$3" ]; then
			"$native_command" "$QUALIFIER"
		elif [ -z "$4" ]; then
			"$native_command" "$QUALIFIER" "$3"
		else
			"$native_command" "$QUALIFIER" "$3" "$4"
		fi
		final_rc=$?

	elif [ -n "$CMD_FOUND" ]; then
		# Available as a shell function
		__sdk_"$converted_command_name" "$QUALIFIER" "$3" "$4"
		final_rc=$?
	fi

	# Attempt upgrade after all is done
	if [[ "$COMMAND" != "selfupdate" && "$sdkman_selfupdate_feature" == "true" && "$sdkman_auto_update" == "true" ]]; then
		__sdkman_auto_update "$SDKMAN_REMOTE_VERSION" "$SDKMAN_VERSION"
	fi
	return $final_rc
}
