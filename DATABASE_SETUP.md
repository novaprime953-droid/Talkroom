# MongoDB and Database Configuration

## Environment Variables

Create a `.env.local` file in the `/platform` directory with:

```env
# MongoDB Connection
MONGODB_URI=mongodb+srv://<username>:<password>@<cluster>.mongodb.net/talkroom?retryWrites=true&w=majority

# API Configuration
API_BASE_URL=http://localhost:3000

# Authentication (optional)
JWT_SECRET=your_jwt_secret_key_here
SESSION_SECRET=your_session_secret_here

# File Storage (optional - for CDN)
AWS_ACCESS_KEY_ID=your_aws_key
AWS_SECRET_ACCESS_KEY=your_aws_secret
S3_BUCKET=your_bucket_name
```

## For Vercel Deployment

Add these environment variables in Vercel dashboard:
1. Go to Project Settings → Environment Variables
2. Add all variables from above
3. Select environments: Production, Preview, Development
4. Deploy

## Database Initialization

On first deployment, MongoDB will auto-create collections:
- users
- rooms
- messages
- wallets
- transactions
- gifts
- pk_battles
- battle_stats

## Indexes (Optional - for better performance)

Run these commands in MongoDB Compass or Atlas:

```javascript
// Users collection
db.users.createIndex({ email: 1 }, { unique: true });
db.users.createIndex({ username: 1 });
db.users.createIndex({ level: -1 });

// Wallets collection
db.wallets.createIndex({ userId: 1 }, { unique: true });

// Rooms collection
db.rooms.createIndex({ status: 1 });
db.rooms.createIndex({ category: 1 });
db.rooms.createIndex({ createdAt: -1 });

// PK Battles collection
db.pk_battles.createIndex({ roomId: 1 });
db.pk_battles.createIndex({ status: 1 });
```
