#!/usr/bin/bash


# Downloads specific spell dictionary for specific language.
# Supports only with first part of language without country code.
#
# Requires curl.

UTF_8_LANGUAGE="$1.utf-8.spl"
ASCII_LANGUAGE="$1.ascii.spl"
SITE=https://ftp.nluug.nl/vim/runtime/spell

curl "$SITE/$UTF_8_LANGUAGE" --output "$UTF_8_LANGUAGE"
curl "$SITE/$ASCII_LANGUAGE" --output "$ASCII_LANGUAGE"
