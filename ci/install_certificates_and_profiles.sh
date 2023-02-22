#!/bin/sh

echo "Installing certificates and profiles..."

echo "Decode certificates and profiles"

echo $APPLE_CERT_G3 | base64 --decode -i - > apple.cer
echo $SIGN_CER_BASE64 | base64 --decode -i - > certificate.cer 
echo $SIGN_KEY_BASE64 | base64 --decode -i - > key.p12
echo $SIGN_PROV_PROFILE_BASE64 | base64 --decode -i - > profile.mobileprovision

echo "Ensure that keychain is not existing"

echo "Create Keychain and import certificates"

echo "Create keychain"
security create-keychain -p "$TEMP_KEYCHAIN_PASSWORD" $TEMP_KEYCHAIN_USER
security list-keychains -s $TEMP_KEYCHAIN_USER

echo "Set default keychain"
security default-keychain -s $TEMP_KEYCHAIN_USER

echo "Unlock keychain"
security unlock-keychain -p "$TEMP_KEYCHAIN_PASSWORD" $TEMP_KEYCHAIN_USER

echo "Set keychain timeout"
security set-keychain-settings -t 3600 -l $TEMP_KEYCHAIN_USER

echo "List keychains:"
security list-keychains

echo "Import certificates"
security import apple.cer -t cert -k "$TEMP_KEYCHAIN_USER"
security import certificate.cer -t cert -k "$TEMP_KEYCHAIN_USER" 
security import key.p12 -t priv -k "$TEMP_KEYCHAIN_USER" -P ""
security set-key-partition-list -S apple-tool:,apple: -s -k $TEMP_KEYCHAIN_PASSWORD $TEMP_KEYCHAIN_USER

echo "Import provisioning profile"
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/

