#!/bin/sh

echo "Installing certificates and profiles..."

echo "Decode certificates and profiles"

echo $SIGN_CER_BASE64 | base64 --decode -i - > certificate.cer 
echo $SIGN_KEY_BASE64 | base64 --decode -i - > key.p12
echo $SIGN_PROV_PROFILE_BASE64 | base64 --decode -i - > profile.mobileprovision

echo "Create Keychain and import certificates and profiles"
KEYCHAIN_PATH=${TEMP_KEYCHAIN_USER}.keychain

security create-keychain -p "$TEMP_KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security list-keychains
security default-keychain -s "$KEYCHAIN_PATH"
security unlock-keychain -p "$TEMP_KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security list-keychains
# security import certificate.cer -t cert -k "$TEMP_KEYCHAIN_USER" 
# security import key.p12 -t pkcs12 -k "$TEMP_KEYCHAIN_USER"
# security set-key-partition-list -S apple-tool:,apple: -s -k $TEMP_KEYCHAIN_PASSWORD $KEYCHAIN_PATH

