# Talk Room

Flutter voice chat app + Next.js backend/admin for Vercel.

## Repo structure

```
TalkRoom/
├── lib/                 # Flutter mobile app
├── platform/            # Next.js API + admin + web panels (deploy to Vercel)
├── assets/              # Lottie + SVGA animations
└── android/ / ios/
```

## 1. Push to GitHub

Repo: https://github.com/novaprime953-droid/Talkroom.git

If push fails with "Repository not found", create the empty repo on GitHub first, then:

```powershell
cd D:\APKs\TalkRoom
git add -A
git commit -m "Add platform backend, admin panels, and API integration"
git push -u origin main
```

Use GitHub Desktop, PAT, or SSH if authentication is required.

## 2. Deploy backend on Vercel

1. Import `novaprime953-droid/Talkroom` in Vercel
2. Set **Root Directory** to `platform`
3. Framework: Next.js (auto-detected)
4. Deploy

Your live URL will be like `https://talkroom-xxxx.vercel.app`

### After deploy — test API

- `https://YOUR-URL.vercel.app/api/config`
- `https://YOUR-URL.vercel.app/admin` — admin panel
- `https://YOUR-URL.vercel.app/panels/wallet` — wallet web panel

## 3. Connect Flutter app to your Vercel URL

```powershell
cd D:\APKs\TalkRoom
$env:PATH = "D:\flutter_windows_3.41.1-stable\flutter\bin;" + $env:PATH
flutter pub get
flutter run --dart-define=API_BASE_URL=https://YOUR-URL.vercel.app
```

With API URL set:
- Home loads rooms from `/api/rooms`
- Profile opens web panels (wallet, tasks, help) in browser
- Gifts/messages can use same backend

Without API URL, app uses local mock data.

## 4. Build APK

Requires valid JDK 17 (`JAVA_HOME`).

```powershell
flutter build apk --release --dart-define=API_BASE_URL=https://YOUR-URL.vercel.app
```

## Platform features

| Route | Purpose |
|-------|---------|
| `/api/config` | App config + panel URLs for Flutter |
| `/api/rooms` | Voice rooms |
| `/api/gifts` | Gift catalog |
| `/api/users` | Users |
| `/api/messages` | Chat messages |
| `/api/pk` | PK battles |
| `/admin` | Admin dashboard |
| `/panels/wallet` | Recharge (WebView) |
| `/panels/events` | Events center |
| `/panels/tasks` | Task center |
| `/panels/rank` | Leaderboards |
| `/panels/agency` | Agency center |
| `/panels/help` | Support |

## Flutter run (local mock)

```powershell
flutter run
```

## License

See LICENSE.
