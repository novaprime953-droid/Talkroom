# TalkRoom Vercel Deployment Guide

## Prerequisites

1. **GitHub Account** - Repository must be on GitHub
2. **Vercel Account** - Sign up at vercel.com
3. **MongoDB Atlas Account** - For database (mongodb.com)

## Step 1: Prepare MongoDB

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a new project and cluster
3. Get connection string: `mongodb+srv://username:password@cluster.mongodb.net/talkroom`
4. Note your username and password

## Step 2: Deploy to Vercel

### Option A: Using Vercel Dashboard (Recommended)

1. Go to [vercel.com](https://vercel.com)
2. Click "Import Project"
3. Paste GitHub repo: `https://github.com/novaprime953-droid/Talkroom.git`
4. Select "Next.js" as framework
5. In "Root Directory", select `/platform` (important!)
6. Click "Deploy"

### Option B: Using Vercel CLI

```powershell
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Navigate to platform directory
cd d:\APKs\TalkRoom\platform

# Deploy
vercel deploy --prod
```

## Step 3: Configure Environment Variables

In Vercel Dashboard:

1. Go to Project → Settings → Environment Variables
2. Add variables:
   - `MONGODB_URI` = your connection string
   - `API_BASE_URL` = `https://talkroom-xxx.vercel.app`
   - `NODE_ENV` = `production`

3. Redeploy after adding variables

## Step 4: Verify Deployment

1. Go to your Vercel URL: `https://talkroom-xxx.vercel.app`
2. Test API endpoints:
   - `GET https://talkroom-xxx.vercel.app/api/rooms`
   - `GET https://talkroom-xxx.vercel.app/api/users`
   - `GET https://talkroom-xxx.vercel.app/api/gifts`

## Expected Output

```json
{
  "success": true,
  "data": [...],
  "message": "...",
  "timestamp": "2026-06-20T..."
}
```

## Troubleshooting

### Build Fails
- Check `/platform/package.json` has all dependencies
- Ensure `next.config.mjs` is configured correctly
- Run locally: `npm run build` in `/platform`

### API Errors
- Verify MongoDB URI in environment variables
- Check all required env vars are set
- Review build logs in Vercel dashboard

### Cold Starts
- First request may take 5-10 seconds
- Subsequent requests are fast
- Upgrade Vercel plan if needed

## Next Steps

1. **Database Indexes**: Create MongoDB indexes for performance
2. **Flutter Integration**: Update app with Vercel URL
3. **Admin Panel**: Connect to API endpoints
4. **Monitoring**: Set up error tracking (Sentry)

## Production Checklist

- [ ] MongoDB Atlas cluster created
- [ ] GitHub repository public/private (choose preferred)
- [ ] Environment variables set in Vercel
- [ ] Database initializes on first API call
- [ ] API endpoints tested and working
- [ ] Flutter app updated with API URL
- [ ] SSL certificate active (Vercel provides free)

---

**Your Deployed Backend URL**: `https://talkroom-xxx.vercel.app`
(Replace `xxx` with your actual Vercel project name)
