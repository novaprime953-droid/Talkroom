# Talk Room

**Talk Room** is a professional voice chat room app built with Flutter. It combines voice room hosting, VIP/SVIP entry effects, gift animations, avatar frames, PK battles, and lucky gift jackpots — with an original deep navy / teal / gold glass-morphism design.

## Features

- **Home** — Featured live rooms and discovery grid
- **Explore** — Category filters and PK Battle arena
- **Messages** — Conversation inbox
- **Profile** — VIP tiers, avatar frames, wallet
- **Voice Room** — Mic seat grid, live chat, gift panel, SVIP entry banner
- **PK Battle** — VS screen with score bar, timer, supporters
- **Gifts** — Categories (Popular, Luxury, Lucky, SVIP) with Lottie + SVGA animations
- **Lucky Gifts** — Jackpot overlay with multiplier effects

## Assets

Bundled assets are sourced from extracted reference APKs for development/demo:

- **Lottie** — `assets/lottie/` (from Chatna extracted assets)
- **SVGA** — `assets/svga/` (SVIP entry + gift animations from NiuChat)

## Prerequisites

- Flutter SDK (tested with 3.41.1)
- Android Studio / Android SDK (for APK build)
- Git safe directory for Flutter (if ownership warning appears)

### Flutter PATH (Windows)

```powershell
$env:PATH = "D:\flutter_windows_3.41.1-stable\flutter\bin;" + $env:PATH
```

### Git ownership workaround (without global config)

```powershell
$env:GIT_CONFIG_COUNT = "1"
$env:GIT_CONFIG_KEY_0 = "safe.directory"
$env:GIT_CONFIG_VALUE_0 = "D:/flutter_windows_3.41.1-stable/flutter"
```

## Setup

```powershell
cd D:\APKs\TalkRoom
$env:PATH = "D:\flutter_windows_3.41.1-stable\flutter\bin;" + $env:PATH
$env:GIT_CONFIG_COUNT = "1"
$env:GIT_CONFIG_KEY_0 = "safe.directory"
$env:GIT_CONFIG_VALUE_0 = "D:/flutter_windows_3.41.1-stable/flutter"
flutter pub get
```

## Run

```powershell
flutter run
```

For a specific device:

```powershell
flutter devices
flutter run -d <device_id>
```

Web preview:

```powershell
flutter run -d chrome
```

## Build APK

```powershell
flutter build apk --release
```

Output: `build\app\outputs\flutter-apk\app-release.apk`

Split per ABI (smaller files):

```powershell
flutter build apk --split-per-abi
```

## Analyze

```powershell
flutter analyze
```

## Project Structure

```
TalkRoom/
├── assets/
│   ├── lottie/          # Lottie animations (gifts, PK, mic, etc.)
│   └── svga/            # SVIP entry + gift SVGA files
├── lib/
│   ├── main.dart
│   ├── data/mock_data.dart
│   ├── models/          # User, Room, Gift, ChatMessage
│   ├── screens/         # Home, Explore, Messages, Profile, VoiceRoom, PK
│   ├── theme/           # Colors + Theme
│   └── widgets/         # Glass UI, gifts, avatar frames, chat
├── android/
├── ios/
└── pubspec.yaml
```

## Dependencies

| Package | Purpose |
|---------|---------|
| `google_fonts` | Plus Jakarta Sans typography |
| `lottie` | Gift & UI animations |
| Custom `SvgaAnimation` | SVIP entry + SVGA gift motion (fallback; `.svga` files bundled for future native player) |

## Notes

- All room data is **mock/demo** — no backend required to run the UI.
- Replace mock data in `lib/data/mock_data.dart` with your API when ready.
- Ensure you have rights to use bundled animation assets in production.

## License

See LICENSE file.
