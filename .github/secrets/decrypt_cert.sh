#!/bin/sh

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_CERTIFICATE_ENCRYPT" --output ./.github/secrets/Certificate.p12 ./.github/secrets/Certificate.p12.gpg

security create-keychain -p "" build.keychain
security import ./.github/secrets/Certificate.p12 -t agg -k ~/Library/Keychains/build.keychain -P "$IOS_CERTIFICATE_PASS" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain

