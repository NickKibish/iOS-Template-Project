#!/bin/sh

echo "Installing certificates and profiles..."

echo "Decode certificates and profiles"

echo $SIGN_CER_BASE64 | base64 --decode -i - > certificate.cer 
echo $SIGN_KEY_BASE64 | base64 --decode -i - > key.p12
echo $SIGN_PROV_PROFILE_BASE64 | base64 --decode -i - > profile.mobileprovision

echo "Create Keychain and import certificates"
KEYCHAIN_PATH=${TEMP_KEYCHAIN_USER}.keychain

security create-keychain -p "$TEMP_KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security default-keychain -s "$KEYCHAIN_PATH"
security unlock-keychain -p "$TEMP_KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security list-keychains

security import certificate.cer -t cert -k "$KEYCHAIN_PATH" 
security import key.p12 -t priv -k "$KEYCHAIN_PATH" -P ""
security set-key-partition-list -S apple-tool:,apple: -s -k $TEMP_KEYCHAIN_PASSWORD $KEYCHAIN_PATH

echo "Import provisioning profile"
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/

