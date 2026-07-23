# iOS Archive Instructions (v0.1.0-alpha)

Building and archiving an iOS `.ipa` requires Xcode on macOS, which is not
available in this (Windows) development environment. Once on a macOS
machine with Xcode installed:

1. `flutter pub get`
2. `cd ios && pod install && cd ..` (if CocoaPods is used by any plugin)
3. Open `ios/Runner.xcworkspace` in Xcode, or run:
   ```bash
   flutter build ipa --release
   ```
4. In Xcode, select **Product → Archive** (or let `flutter build ipa`
   produce `build/ios/archive/Runner.xcarchive`).
5. Set the signing team / provisioning profile for internal TestFlight
   distribution under **Signing & Capabilities** on the `Runner` target.
6. Use **Xcode Organizer → Distribute App → TestFlight (Internal Testing)**
   to upload, or `xcrun altool`/`xcrun notarytool` equivalents via CI.

No signing certificates, provisioning profiles, or App Store Connect
credentials are stored in this repository — those must be supplied by
whoever performs the actual archive/upload step, consistent with Task.md's
prohibition on committing signing material.
