// MongoDB User Repository Implementation
import { ObjectId } from 'mongodb';
import { getCollection, Collections } from './mongodb';
import { IUserRepository } from './repositories';

class UserRepository implements IUserRepository {
  async create(data: any): Promise<any> {
    const doc = {
      ...data,
      createdAt: new Date(),
      updatedAt: new Date(),
    };
    const result = await getCollection(Collections.USERS).insertOne(doc);
    return { ...doc, _id: result.insertedId };
  }

  async findById(id: string): Promise<any | null> {
    return await getCollection(Collections.USERS).findOne({
      _id: new ObjectId(id),
    });
  }

  async findByEmail(email: string): Promise<any | null> {
    return await getCollection(Collections.USERS).findOne({ email });
  }

  async findByUsername(username: string): Promise<any | null> {
    return await getCollection(Collections.USERS).findOne({ username });
  }

  async searchByUsername(query: string, limit: number = 20): Promise<any[]> {
    return await getCollection(Collections.USERS)
      .find({ username: { $regex: query, $options: 'i' } })
      .limit(limit)
      .toArray();
  }

  async getTopByLevel(limit: number = 100): Promise<any[]> {
    return await getCollection(Collections.USERS)
      .find({})
      .sort({ level: -1 })
      .limit(limit)
      .toArray();
  }

  async findAll(limit?: number, skip?: number): Promise<any[]> {
    let query = getCollection(Collections.USERS).find({});
    if (skip) query = query.skip(skip);
    if (limit) query = query.limit(limit);
    return await query.toArray();
  }

  async update(id: string, data: any): Promise<any | null> {
    const result = await getCollection(Collections.USERS).findOneAndUpdate(
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
    const result = await getCollection(Collections.USERS).deleteOne({
      _id: new ObjectId(id),
    });
    return result.deletedCount > 0;
  }

  async addExperience(userId: string, amount: number): Promise<any> {
    const result = await getCollection(Collections.USERS).findOneAndUpdate(
      { _id: new ObjectId(userId) },
      {
        $inc: {
          experience: amount,
          level: Math.floor(amount / 1000),
        },
      },
      { returnDocument: 'after' }
    );
    return result.value;
  }

  async addBadge(userId: string, badge: string): Promise<void> {
    await getCollection(Collections.USERS).updateOne(
      { _id: new ObjectId(userId) },
      {
        $addToSet: { badges: badge },
      }
    );
  }
}

export default new UserRepository();
