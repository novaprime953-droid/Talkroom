// MongoDB Wallet Repository Implementation
import { ObjectId } from 'mongodb';
import { getCollection, Collections } from './mongodb';
import { IWalletRepository } from './repositories';

class WalletRepository implements IWalletRepository {
  async create(data: any): Promise<any> {
    const doc = {
      ...data,
      createdAt: new Date(),
      updatedAt: new Date(),
    };
    const result = await getCollection(Collections.WALLETS).insertOne(doc);
    return { ...doc, _id: result.insertedId };
  }

  async findById(id: string): Promise<any | null> {
    return await getCollection(Collections.WALLETS).findOne({
      _id: new ObjectId(id),
    });
  }

  async findByUserId(userId: string): Promise<any | null> {
    return await getCollection(Collections.WALLETS).findOne({
      userId: new ObjectId(userId),
    });
  }

  async findAll(limit?: number, skip?: number): Promise<any[]> {
    let query = getCollection(Collections.WALLETS).find({});
    if (skip) query = query.skip(skip);
    if (limit) query = query.limit(limit);
    return await query.toArray();
  }

  async update(id: string, data: any): Promise<any | null> {
    const result = await getCollection(Collections.WALLETS).findOneAndUpdate(
      { _id: new ObjectId(id) },
      {
        $set: {
          ...data,
          updatedAt: new Date(),
        },
      },
      { returnDocument: 'after' }
    );
    return result.value;
  }

  async delete(id: string): Promise<boolean> {
    const result = await getCollection(Collections.WALLETS).deleteOne({
      _id: new ObjectId(id),
    });
    return result.deletedCount > 0;
  }

  async addDiamonds(userId: string, amount: number): Promise<any> {
    const result = await getCollection(Collections.WALLETS).findOneAndUpdate(
      { userId: new ObjectId(userId) },
      {
        $inc: {
          diamonds: amount,
          totalDiamondsEarned: amount,
        },
        $set: {
          updatedAt: new Date(),
        },
      },
      { returnDocument: 'after' }
    );
    return result.value;
  }

  async spendDiamonds(userId: string, amount: number): Promise<any> {
    const result = await getCollection(Collections.WALLETS).findOneAndUpdate(
      { userId: new ObjectId(userId), diamonds: { $gte: amount } },
      {
        $inc: {
          diamonds: -amount,
          totalDiamondsSpent: amount,
        },
        $set: {
          updatedAt: new Date(),
        },
      },
      { returnDocument: 'after' }
    );
    return result.value;
  }
}

export default new WalletRepository();
