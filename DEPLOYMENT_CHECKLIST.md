# TalkRoom Complete Deployment Checklist

## Phase 1: Database Setup ✅

### MongoDB Atlas
- [ ] Create account at mongodb.com
- [ ] Create new project
- [ ] Create cluster (M0 free tier)
- [ ] Add IP address: 0.0.0.0/0 (for Vercel)
- [ ] Create database user
- [ ] Get connection string: `mongodb+srv://user:pass@cluster.mongodb.net/talkroom`

### Local Testing
```bash
cd platform
npm install
npm run build
npm run start
# Test at http://localhost:3000/api/rooms
```

## Phase 2: Backend Deployment (Vercel) ⏳

### Prerequisites
- GitHub repository with code pushed
- Vercel account (vercel.com)
- MongoDB connection string ready

### Deployment Steps
1. Go to https://vercel.com
2. Click "Import Project"
3. Select GitHub repository: `novaprime953-droid/Talkroom`
4. Configure:
   - Framework: **Next.js**
   - Root Directory: **/platform** ⚠️ Important!
5. Add Environment Variables:
   - `MONGODB_URI` = your connection string
   - `NODE_ENV` = `production`
6. Click "Deploy"
7. Get URL: `https://talkroom-xxxxx.vercel.app`

### Verify Deployment
```bash
# Test endpoints
curl https://talkroom-xxxxx.vercel.app/api/rooms
curl https://talkroom-xxxxx.vercel.app/api/users
curl https://talkroom-xxxxx.vercel.app/api/gifts
curl https://talkroom-xxxxx.vercel.app/api/pk
```

Expected Response:
```json
{
  "success": true,
  "data": [...],
  "message": "...",
  "timestamp": "2026-06-20T..."
}
```

## Phase 3: Flutter Integration ⏳

### Update Backend URL
File: `lib/main.dart`

```dart
// Before
const String API_BASE_URL = 'http://localhost:3000';

// After
const String API_BASE_URL = 'https://talkroom-xxxxx.vercel.app';
```

### Test Web
```bash
flutter run -d chrome
# App will connect to live backend
```

### Test Android
```bash
# Connect Android device via USB
# Enable USB Debugging on device
adb devices

# Authorize device when prompt appears on phone

# Build and run
flutter run
```

### Build Release APK
```bash
flutter build apk --release --dart-define=API_BASE_URL=https://talkroom-xxxxx.vercel.app
# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

## Phase 4: Admin Panel Update ⏳

### Update API Client
File: `platform/src/lib/adminApiClient.ts`

```typescript
const API_BASE = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';
```

### Environment Variable
File: `platform/.env.local`

```env
NEXT_PUBLIC_API_URL=https://talkroom-xxxxx.vercel.app/api
```

### Test Admin Features
- [ ] User Management: `/admin/users`
- [ ] Room Management: `/admin/rooms`
- [ ] Gift Management: `/admin/gifts`
- [ ] PK Battles: `/admin/pk`
- [ ] Wallet Management: `/admin/vip`

## Quick Links

### Backend Documentation
- Architecture: [ARCHITECTURE.md](ARCHITECTURE.md)
- Database Setup: [DATABASE_SETUP.md](DATABASE_SETUP.md)
- Vercel Deployment: [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)

### Integration Guides
- Flutter Integration: [FLUTTER_INTEGRATION.md](FLUTTER_INTEGRATION.md)
- Admin Panel: [ADMIN_PANEL_INTEGRATION.md](ADMIN_PANEL_INTEGRATION.md)

### GitHub
- Repository: https://github.com/novaprime953-droid/Talkroom
- Backend Code: `/platform/src/`
- Services: `/src/services/`
- Database: `/src/db/`

### Deployed URLs
- **Backend API**: `https://talkroom-xxxxx.vercel.app/api`
- **Admin Panel**: `https://talkroom-xxxxx.vercel.app/admin`
- **Web App**: `https://talkroom-xxxxx.vercel.app` (Flutter web)

## API Endpoints Reference

### Users API
```
POST   /api/users                    # Register user
GET    /api/users                    # List/search users
GET    /api/users/[id]               # Get user profile
```

### Rooms API
```
GET    /api/rooms                    # List all rooms
POST   /api/rooms                    # Create room
GET    /api/rooms/[id]               # Get room details
POST   /api/rooms/[id]/join          # Join room
POST   /api/rooms/[id]/actions       # Room actions (leave, mic, promote, mute, close)
```

### Gifts API
```
GET    /api/gifts                    # List all gifts
POST   /api/gifts                    # Send gift
```

### Messages API
```
GET    /api/messages?roomId=...      # Get room messages
POST   /api/messages                 # Send message
```

### PK API
```
GET    /api/pk                       # List battles
POST   /api/pk                       # Initiate PK
GET    /api/pk/[id]                  # Get battle details
PUT    /api/pk/[id]                  # Update battle (accept, reject, score, end)
```

### Wallet API
```
GET    /api/wallet/[userId]          # Get wallet balance
POST   /api/wallet                   # Recharge diamonds
```

## Database Collections

MongoDB will auto-create these collections:
- `users` - User accounts, profiles, stats
- `rooms` - Voice chat rooms
- `messages` - Chat messages
- `wallets` - Diamond wallets
- `transactions` - Payment transactions
- `gifts` - Gift catalog
- `pk_battles` - PK battle records
- `battle_stats` - User PK statistics

## Troubleshooting

### MongoDB Connection Failed
1. Check connection string format
2. Verify IP whitelist includes 0.0.0.0/0
3. Check MongoDB user password (special chars need encoding)
4. Test locally first: `mongodb://localhost:27017/talkroom`

### Vercel Deploy Failed
1. Check `/platform` directory exists
2. Verify `package.json` has all dependencies
3. Check environment variables are set
4. Review build logs in Vercel dashboard

### Flutter API Connection Failed
1. Verify backend URL is correct
2. Check CORS headers (Vercel provides automatic CORS)
3. Test with curl: `curl https://talkroom-xxxxx.vercel.app/api/rooms`
4. Check Flutter app logs for network errors

### Admin Panel Not Updating
1. Clear browser cache
2. Check `NEXT_PUBLIC_API_URL` environment variable
3. Verify backend endpoints are working
4. Check browser console for API errors

## Performance Optimization

### Database Indexes
```javascript
db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ username: 1 });
db.wallets.createIndex({ userId: 1 }, { unique: true });
db.pk_battles.createIndex({ status: 1 });
```

### Caching
- Add Redis for session caching
- Cache gift catalog (updates infrequently)
- Cache user leaderboards (update daily)

### Monitoring
- Set up Vercel Analytics
- Add error tracking (Sentry)
- Monitor database performance (MongoDB Atlas)

## Security Checklist

- [ ] Use HTTPS only (Vercel provides SSL)
- [ ] Set strong MongoDB password
- [ ] Restrict database access by IP
- [ ] Use environment variables for secrets
- [ ] Implement rate limiting (done in utils/api.ts)
- [ ] Validate all inputs (done in services)
- [ ] Never log sensitive data
- [ ] Enable MongoDB encryption at rest

## Success Criteria

- ✅ MongoDB database connected
- ✅ Vercel backend deployed at live URL
- ✅ All API endpoints responding with correct format
- ✅ Flutter app connecting to backend APIs
- ✅ Admin panel showing real data from database
- ✅ User can register and create rooms
- ✅ Users can send gifts and initiate PK battles
- ✅ Wallet system working with diamonds

---

**Estimated Time**: 
- Database setup: 10 minutes
- Backend deployment: 5 minutes  
- Integration testing: 15 minutes
- **Total: ~30 minutes**

**Status**: Ready for immediate deployment! 🚀
