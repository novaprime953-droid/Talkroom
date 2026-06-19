// MongoDB Room Repository Implementation
import { ObjectId } from 'mongodb';
import { getCollection, Collections } from './mongodb';
import { IRoomRepository } from './repositories';

class RoomRepository implements IRoomRepository {
  async create(data: any): Promise<any> {
    const doc = {
      ...data,
      createdAt: new Date(),
      updatedAt: new Date(),
    };
    const result = await getCollection(Collections.ROOMS).insertOne(doc);
    return { ...doc, _id: result.insertedId };
  }

  async findById(id: string): Promise<any | null> {
    return await getCollection(Collections.ROOMS).findOne({
      _id: new ObjectId(id),
    });
  }

  async findByStatus(status: string): Promise<any[]> {
    return await getCollection(Collections.ROOMS)
      .find({ status })
      .toArray();
  }

  async findByCategory(category: string): Promise<any[]> {
    return await getCollection(Collections.ROOMS)
      .find({ category })
      .toArray();
  }

  async findAll(limit?: number, skip?: number): Promise<any[]> {
    let query = getCollection(Collections.ROOMS).find({});
    if (skip) query = query.skip(skip);
    if (limit) query = query.limit(limit);
    return await query.toArray();
  }

  async update(id: string, data: any): Promise<any | null> {
    const result = await getCollection(Collections.ROOMS).findOneAndUpdate(
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
    const result = await getCollection(Collections.ROOMS).deleteOne({
      _id: new ObjectId(id),
    });
    return result.deletedCount > 0;
  }

  async updateMemberCount(roomId: string, count: number): Promise<void> {
    await getCollection(Collections.ROOMS).updateOne(
      { _id: new ObjectId(roomId) },
      {
        $set: {
          currentMemberCount: count,
          updatedAt: new Date(),
        },
      }
    );
  }

  async addMember(roomId: string, member: any): Promise<void> {
    await getCollection(Collections.ROOMS).updateOne(
      { _id: new ObjectId(roomId) },
      {
        $push: { members: member },
        $inc: { currentMemberCount: 1 },
        $set: { updatedAt: new Date() },
      }
    );
  }

  async removeMember(roomId: string, userId: string): Promise<void> {
    await getCollection(Collections.ROOMS).updateOne(
      { _id: new ObjectId(roomId) },
      {
        $pull: { members: { userId: new ObjectId(userId) } },
        $inc: { currentMemberCount: -1 },
        $set: { updatedAt: new Date() },
      }
    );
  }
}

export default new RoomRepository();
