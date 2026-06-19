// MongoDB Connection Manager
import { MongoClient, Db, Collection } from 'mongodb';

let client: MongoClient | null = null;
let db: Db | null = null;

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/talkroom';
const DB_NAME = 'talkroom';

export const connectDB = async (): Promise<Db> => {
  if (db) {
    return db;
  }

  try {
    client = new MongoClient(MONGODB_URI);
    await client.connect();
    db = client.db(DB_NAME);
    console.log('✅ Connected to MongoDB');
    return db;
  } catch (error) {
    console.error('❌ MongoDB connection failed:', error);
    throw error;
  }
};

export const getDB = (): Db => {
  if (!db) {
    throw new Error('Database not connected. Call connectDB() first.');
  }
  return db;
};

export const closeDB = async (): Promise<void> => {
  if (client) {
    await client.close();
    db = null;
    client = null;
    console.log('✅ MongoDB connection closed');
  }
};

// Collection getters
export const getCollection = (name: string): Collection => {
  return getDB().collection(name);
};

export const Collections = {
  USERS: 'users',
  ROOMS: 'rooms',
  MESSAGES: 'messages',
  WALLETS: 'wallets',
  TRANSACTIONS: 'transactions',
  GIFTS: 'gifts',
  PK_BATTLES: 'pk_battles',
  BATTLE_STATS: 'battle_stats',
};
