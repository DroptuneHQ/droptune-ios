# Droptune iOS Client

This is a [Turbolinks-iOS](https://github.com/turbolinks/turbolinks-ios) client for [Droptune](https://droptune.co).

## Development

🚨 Follow the configuration steps before trying to open the project in Xcode.

### Configuration

The two targets are configured by the `Config.xcconfig` and `Config-dev.xcconfig` files. These are excluded from git, but samples are provided.

`$ cp Config.sample.xcconfig Config.xcconfig`

`$ cp Config-dev.sample.xcconfig Config-dev.xcconfig`

Modify the two config files to your needs.

### Xcode

Open the `Droptune-iOS.xcworkspace` in Xcode AFTER making your configuration changes.

There are two targets, Droptune-iOS and Droptune-iOS-dev. The targets are used to run the project against different environments (your local development instance of Droptune vs. https://droptune.co). Select the appropriate target prior to running the app.
