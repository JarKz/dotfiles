#!/bin/bash
#Post Hook: default-zip
function __sdkman_post_installation_hook {
    __sdkman_echo_debug "No macOS ARM 64bit post-install hook found for Springboot 3.0.1."
    __sdkman_echo_debug "Moving $binary_input to $zip_output"
    mv -f "$binary_input" "$zip_output"
}