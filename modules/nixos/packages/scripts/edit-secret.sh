#!/usr/bin/env bash

# exit on error
set -e

SECURE_FILE=$1
PUBLIC_KEY="age1ly49z83aaalg38yr4fl24nhu4cvl0467rcsx6lnp9s4eklcer3tqjmnv4p"
KEY_FILE="/data/key.age"

if [[ -z "$SECURE_FILE" ]]; then
    echo "Usage: edit-secret <file.age>"
    exit 1
fi

# use RAM disk (/dev/shm) if available to avoid writing plain text to SSD
if [[ -d /dev/shm ]]; then
    TMP_FILE=$(mktemp /dev/shm/age-edit.XXXXXX)
else
    TMP_FILE=$(mktemp /tmp/age-edit.XXXXXX)
fi

# ensure cleanup on exit
trap "rm -f $TMP_FILE" EXIT

# decrypt existing file into RAM
if [[ -f "$SECURE_FILE" ]]; then
    # decrypt the key file, then use it to decrypt the target
    age -d -i <(age -d "$KEY_FILE") "$SECURE_FILE" > "$TMP_FILE"
fi

# edit with nvim
nvim "$TMP_FILE"

# re-encrypt using Public Key (no password needed to lock)
age -r "$PUBLIC_KEY" -o "$SECURE_FILE" "$TMP_FILE"

echo "Successfully encrypted: $SECURE_FILE"