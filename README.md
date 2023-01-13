# iOS-Template-Project

## Setup Environment 
### `.env` local file for `fastlane`
* Create a `.env` file in the same directory as the `Fastfile` and add the following
* Add secrets to the `.env` file
    * e.g. `FASTLANE_PASSWORD=your_password`
* Add `.env` to `.gitignore` to prevent secrets from being committed

## Create API Key
1. Log in to [App Store Connect](https://appstoreconnect.apple.com/apps).
2. Select [Users and Access](https://appstoreconnect.apple.com/access/users).
3. Select the API Keys tab.
4. Click Generate API Key or the Add (+) button.
5. Enter a name for the key. The name is for your reference only and is not part of the key itself.
6. Under Access, select the role for the key. The roles that apply to keys are the same roles that apply to users on your team. See [role permissions](https://help.apple.com/app-store-connect/#/deve5f9a89d7).
7. Click Generate.

> ❗️ Store the key securely. You can revoke the key at any time. If you revoke the key, you must generate a new key.

### Create JWT Token

## Match: Synchronizing Certificates and Profiles
