#!/bin/sh

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_CERTIFICATE_ENCRYPT" --output ./.github/secrets/profile.mobileprovision ./.github/secrets/profile.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_CERTIFICATE_ENCRYPT" --output ./.github/secrets/Certificate.p12 ./.github/secrets/Certificate.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/5ffa0f6b-a14e-40dc-a6e5-d182edbc6fe5.mobileprovision

security create-keychain -p "" build.keychain
security import ./.github/secrets/Certificate.p12 -t agg -k ~/Library/Keychains/build.keychain -P "$IOS_CERTIFICATE_PASS" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain
