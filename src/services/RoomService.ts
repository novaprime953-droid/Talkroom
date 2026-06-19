// Room Service - Business Logic for Rooms
// Architecture: Repository Pattern from NiuChat

import { Room, RoomMember, Message } from '@/models';

class RoomService {
  private rooms: Map<string, Room> = new Map();
  private roomMessages: Map<string, Message[]> = new Map();

  /**
   * Create a new room
   * Equivalent to NiuChat's CapsuleService.createRoom()
   */
  async createRoom(data: {
    name: string;
    ownerId: string;
    description?: string;
    category: string;
    isPrivate?: boolean;
    maxMembers?: number;
  }): Promise<Room> {
    const roomId = `room_${Date.now()}_${Math.random()}`;
    
    const room: Room = {
      id: roomId,
      name: data.name,
      description: data.description || '',
      ownerId: data.ownerId,
      category: data.category,
      members: [],
      currentMemberCount: 0,
      maxMembers: data.maxMembers || 8,
      isPrivate: data.isPrivate || false,
      isPK: false,
      createdAt: new Date(),
      updatedAt: new Date(),
      status: 'active',
    };

    this.rooms.set(roomId, room);
    this.roomMessages.set(roomId, []);
    
    return room;
  }

  /**
   * Get room by ID
   */
  async getRoomById(roomId: string): Promise<Room | null> {
    return this.rooms.get(roomId) || null;
  }

  /**
   * Get all active rooms
   */
  async getAllRooms(): Promise<Room[]> {
    return Array.from(this.rooms.values()).filter(r => r.status === 'active');
  }

  /**
   * Get rooms by category
   */
  async getRoomsByCategory(category: string): Promise<Room[]> {
    return Array.from(this.rooms.values()).filter(
      r => r.category === category && r.status === 'active'
    );
  }

  /**
   * Join room (add member)
   * Equivalent to NiuChat's RoomService.joinRoom()
   */
  async joinRoom(roomId: string, userId: string, username: string, avatar?: string): Promise<boolean> {
    const room = this.rooms.get(roomId);
    if (!room) return false;
    
    if (room.currentMemberCount >= room.maxMembers) return false;
    
    const member: RoomMember = {
      userId,
      username,
      avatar,
      role: 'member',
      joinedAt: new Date(),
      microphoneOn: false,
      speakerOn: false,
      muted: false,
      level: 1,
    };

    room.members.push(member);
    room.currentMemberCount++;
    room.updatedAt = new Date();

    return true;
  }

  /**
   * Leave room (remove member)
   */
  async leaveRoom(roomId: string, userId: string): Promise<boolean> {
    const room = this.rooms.get(roomId);
    if (!room) return false;

    const memberIndex = room.members.findIndex(m => m.userId === userId);
    if (memberIndex === -1) return false;

    room.members.splice(memberIndex, 1);
    room.currentMemberCount--;
    room.updatedAt = new Date();

    // Close room if owner leaves and no one else is there
    if (room.ownerId === userId && room.currentMemberCount === 0) {
      room.status = 'closed';
    }

    return true;
  }

  /**
   * Send message in room
   */
  async sendMessage(
    roomId: string,
    userId: string,
    username: string,
    content: string,
    avatar?: string
  ): Promise<Message> {
    const room = this.rooms.get(roomId);
    if (!room) throw new Error('Room not found');

    const message: Message = {
      id: `msg_${Date.now()}_${Math.random()}`,
      roomId,
      userId,
      username,
      avatar,
      content,
      type: 'text',
      createdAt: new Date(),
      isDeleted: false,
    };

    if (!this.roomMessages.has(roomId)) {
      this.roomMessages.set(roomId, []);
    }
    
    this.roomMessages.get(roomId)?.push(message);

    return message;
  }

  /**
   * Get room messages (chat history)
   */
  async getRoomMessages(roomId: string, limit: number = 50): Promise<Message[]> {
    const messages = this.roomMessages.get(roomId) || [];
    return messages.slice(-limit).reverse();
  }

  /**
   * Get room members
   */
  async getRoomMembers(roomId: string): Promise<RoomMember[]> {
    const room = this.rooms.get(roomId);
    return room?.members || [];
  }

  /**
   * Update member microphone status
   * Equivalent to NiuChat's MicService.updateMicStatus()
   */
  async updateMicStatus(roomId: string, userId: string, status: boolean): Promise<void> {
    const room = this.rooms.get(roomId);
    if (!room) return;

    const member = room.members.find(m => m.userId === userId);
    if (member) {
      member.microphoneOn = status;
      room.updatedAt = new Date();
    }
  }

  /**
   * Promote member to moderator
   */
  async promoteMember(roomId: string, userId: string): Promise<void> {
    const room = this.rooms.get(roomId);
    if (!room) return;

    const member = room.members.find(m => m.userId === userId);
    if (member) {
      member.role = 'moderator';
      room.updatedAt = new Date();
    }
  }

  /**
   * Mute member
   */
  async muteMember(roomId: string, userId: string, mute: boolean): Promise<void> {
    const room = this.rooms.get(roomId);
    if (!room) return;

    const member = room.members.find(m => m.userId === userId);
    if (member) {
      member.muted = mute;
      room.updatedAt = new Date();
    }
  }

  /**
   * Close room
   */
  async closeRoom(roomId: string): Promise<void> {
    const room = this.rooms.get(roomId);
    if (room) {
      room.status = 'closed';
      room.members = [];
      room.currentMemberCount = 0;
    }
  }
}

export default new RoomService();
