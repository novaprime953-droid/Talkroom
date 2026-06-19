// Base Repository Interface
export interface IRepository<T> {
  create(data: Partial<T>): Promise<T>;
  findById(id: string): Promise<T | null>;
  findAll(limit?: number, skip?: number): Promise<T[]>;
  update(id: string, data: Partial<T>): Promise<T | null>;
  delete(id: string): Promise<boolean>;
}

// User Repository
export interface IUserRepository extends IRepository<any> {
  findByEmail(email: string): Promise<any | null>;
  findByUsername(username: string): Promise<any | null>;
  searchByUsername(query: string, limit?: number): Promise<any[]>;
  getTopByLevel(limit?: number): Promise<any[]>;
  addExperience(userId: string, amount: number): Promise<any>;
  addBadge(userId: string, badge: string): Promise<void>;
}

// Room Repository
export interface IRoomRepository extends IRepository<any> {
  findByStatus(status: string): Promise<any[]>;
  findByCategory(category: string): Promise<any[]>;
  updateMemberCount(roomId: string, count: number): Promise<void>;
  addMember(roomId: string, member: any): Promise<void>;
  removeMember(roomId: string, userId: string): Promise<void>;
}

// Wallet Repository
export interface IWalletRepository extends IRepository<any> {
  findByUserId(userId: string): Promise<any | null>;
  addDiamonds(userId: string, amount: number): Promise<any>;
  spendDiamonds(userId: string, amount: number): Promise<any>;
}

// Message Repository
export interface IMessageRepository extends IRepository<any> {
  findByRoomId(roomId: string, limit?: number): Promise<any[]>;
  createBatch(messages: any[]): Promise<any[]>;
}

// Transaction Repository
export interface ITransactionRepository extends IRepository<any> {
  findByUserId(userId: string, limit?: number): Promise<any[]>;
  findByRoomId(roomId: string, limit?: number): Promise<any[]>;
}

// PK Battle Repository
export interface IPKBattleRepository extends IRepository<any> {
  findByRoomId(roomId: string): Promise<any[]>;
  findPending(userId: string): Promise<any[]>;
  findByStatus(status: string): Promise<any[]>;
}
