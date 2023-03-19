#!/bin/bash

if [[ ! -z "$CI" ]]; then
    echo "Running on GitHub Actions"
else
    echo "Import environment variables"
    if test -f .env; then
        export $(cat .env)
    elif test -f ci/.env; then
        export $(cat ci/.env)
    fi
fi

if [[ ! -z "$CI" ]]; then # Installing certificates and profiles
    echo "Installing certificates and profiles..."

    echo "Decode certificates and profiles"

    echo $APPLE_CERT_G3 | base64 --decode -i - > apple.cer
    echo $SIGN_CER_BASE64 | base64 --decode -i - > certificate.cer 
    echo $SIGN_KEY_BASE64 | base64 --decode -i - > key.p12
    echo $SIGN_PROV_PROFILE_BASE64 | base64 --decode -i - > $PROVISIONING_PROFILE_SPECIFIER.mobileprovision

    echo "Ensure that keychain is not existing"
    security delete-keychain $TEMP_KEYCHAIN_USER

    echo "Create Keychain and import certificates"

    echo "Create keychain"
    security create-keychain -p "$TEMP_KEYCHAIN_PASSWORD" $TEMP_KEYCHAIN_USER

    echo "Set default keychain"
    security default-keychain -s $TEMP_KEYCHAIN_USER

    echo "Unlock keychain"
    security unlock-keychain -p "$TEMP_KEYCHAIN_PASSWORD" $TEMP_KEYCHAIN_USER

    echo "Set keychain timeout"
    security set-keychain-settings -lut 21600

    echo "List keychains:"
    security list-keychains

    echo "Import certificates"
    security import apple.cer -t cert
    security import certificate.cer -t cert
    security import key.p12 -t priv -P "" -A 

    security list-keychains -d user -s $TEMP_KEYCHAIN_USER
    security set-key-partition-list -S apple:,apple-tool: -s -k $TEMP_KEYCHAIN_PASSWORD 

    echo "Import provisioning profile"
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    cp profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
    ls -la ~/Library/MobileDevice/Provisioning\ Profiles/
fi

echo "Build and archive"
xcodebuild -configuration Release \
    -scheme $XC_SCHEME \
    -derivedDataPath DerivedData \
    -archivePath DerivedData/Archive/$XC_SCHEME archive

echo "Export archive"
xcodebuild -exportArchive \
    -archivePath DerivedData/Archive/$XC_SCHEME.xcarchive \
    -exportOptionsPlist ci/ExportOptions.plist \
    -exportPath DerivedData/ipa

echo "Upload to App Store Connect"
xcrun altool --upload-app --type ios \
    --file DerivedData/ipa/$XC_SCHEME.ipa \
    --apiKey=$APPLE_KEY_ID --apiIssuer=$APPLE_ISSUER_ID \
    -verbose