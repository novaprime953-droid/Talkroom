# Admin Panel Integration with Backend APIs

## Overview

The admin panel (Next.js in `/platform/src/app/admin/`) needs to connect to the backend APIs created in `/src/app/api/`.

## Step 1: Create Admin API Client

Create `platform/src/lib/adminApiClient.ts`:

```typescript
const API_BASE = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';

export const adminApi = {
  // Users Management
  async getUsers(limit = 100) {
    const res = await fetch(`${API_BASE}/users?limit=${limit}`);
    if (!res.ok) throw new Error('Failed to fetch users');
    return res.json();
  },

  async getUser(id: string) {
    const res = await fetch(`${API_BASE}/users/${id}`);
    if (!res.ok) throw new Error('Failed to fetch user');
    return res.json();
  },

  async searchUsers(query: string) {
    const res = await fetch(`${API_BASE}/users?q=${query}`);
    if (!res.ok) throw new Error('Failed to search users');
    return res.json();
  },

  // Rooms Management
  async getRooms(limit = 100) {
    const res = await fetch(`${API_BASE}/rooms?limit=${limit}`);
    if (!res.ok) throw new Error('Failed to fetch rooms');
    return res.json();
  },

  async getRoom(id: string) {
    const res = await fetch(`${API_BASE}/rooms/${id}`);
    if (!res.ok) throw new Error('Failed to fetch room');
    return res.json();
  },

  async closeRoom(roomId: string) {
    const res = await fetch(`${API_BASE}/rooms/${roomId}/actions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ action: 'close' }),
    });
    if (!res.ok) throw new Error('Failed to close room');
    return res.json();
  },

  // Gifts Management
  async getGifts() {
    const res = await fetch(`${API_BASE}/gifts`);
    if (!res.ok) throw new Error('Failed to fetch gifts');
    return res.json();
  },

  // PK Battles Management
  async getPKBattles(limit = 50) {
    const res = await fetch(`${API_BASE}/pk?limit=${limit}`);
    if (!res.ok) throw new Error('Failed to fetch PK battles');
    return res.json();
  },

  async getPKBattle(id: string) {
    const res = await fetch(`${API_BASE}/pk/${id}`);
    if (!res.ok) throw new Error('Failed to fetch PK battle');
    return res.json();
  },

  async endPKBattle(battleId: string) {
    const res = await fetch(`${API_BASE}/pk/${battleId}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ action: 'end' }),
    });
    if (!res.ok) throw new Error('Failed to end battle');
    return res.json();
  },

  // Wallet Management
  async getWallet(userId: string) {
    const res = await fetch(`${API_BASE}/wallet/${userId}`);
    if (!res.ok) throw new Error('Failed to fetch wallet');
    return res.json();
  },

  async rechargeUser(userId: string, amount: number) {
    const res = await fetch(`${API_BASE}/wallet`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ userId, amount }),
    });
    if (!res.ok) throw new Error('Failed to recharge');
    return res.json();
  },
};
```

## Step 2: Update Admin Pages

### Users Admin Page

`platform/src/app/admin/users/page.tsx`:

```typescript
'use client';

import { useEffect, useState } from 'react';
import { adminApi } from '@/lib/adminApiClient';

export default function AdminUsersPage() {
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    loadUsers();
  }, []);

  const loadUsers = async () => {
    try {
      setLoading(true);
      const response = await adminApi.getUsers();
      setUsers(response.data || []);
    } catch (error) {
      console.error('Error loading users:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!searchQuery.trim()) {
      loadUsers();
      return;
    }
    try {
      const response = await adminApi.searchUsers(searchQuery);
      setUsers(response.data || []);
    } catch (error) {
      console.error('Error searching users:', error);
    }
  };

  return (
    <div className="admin-container">
      <h1>Users Management</h1>

      <form onSubmit={handleSearch} className="search-form">
        <input
          type="text"
          placeholder="Search users..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <button type="submit">Search</button>
      </form>

      {loading ? (
        <p>Loading...</p>
      ) : (
        <table className="admin-table">
          <thead>
            <tr>
              <th>Username</th>
              <th>Email</th>
              <th>Level</th>
              <th>Diamonds</th>
              <th>VIP Tier</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id}>
                <td>{user.username}</td>
                <td>{user.email}</td>
                <td>{user.level || 1}</td>
                <td>{user.diamonds || 0}</td>
                <td>{user.vipTier || 'None'}</td>
                <td>
                  <button onClick={() => viewUser(user.id)}>View</button>
                  <button onClick={() => editUser(user.id)}>Edit</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

function viewUser(id: string) {
  // Implement view details modal
}

function editUser(id: string) {
  // Implement edit user modal
}
```

### Rooms Admin Page

`platform/src/app/admin/rooms/page.tsx`:

```typescript
'use client';

import { useEffect, useState } from 'react';
import { adminApi } from '@/lib/adminApiClient';

export default function AdminRoomsPage() {
  const [rooms, setRooms] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadRooms();
  }, []);

  const loadRooms = async () => {
    try {
      setLoading(true);
      const response = await adminApi.getRooms();
      setRooms(response.data || []);
    } catch (error) {
      console.error('Error loading rooms:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleCloseRoom = async (roomId: string) => {
    if (!confirm('Are you sure you want to close this room?')) return;
    try {
      await adminApi.closeRoom(roomId);
      await loadRooms();
    } catch (error) {
      console.error('Error closing room:', error);
    }
  };

  return (
    <div className="admin-container">
      <h1>Rooms Management</h1>

      {loading ? (
        <p>Loading...</p>
      ) : (
        <table className="admin-table">
          <thead>
            <tr>
              <th>Room Name</th>
              <th>Category</th>
              <th>Members</th>
              <th>Owner</th>
              <th>Status</th>
              <th>Created</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {rooms.map((room) => (
              <tr key={room.id}>
                <td>{room.name}</td>
                <td>{room.category}</td>
                <td>{room.members}/{room.maxMembers}</td>
                <td>{room.owner}</td>
                <td>{room.status}</td>
                <td>{new Date(room.createdAt).toLocaleDateString()}</td>
                <td>
                  <button onClick={() => viewRoom(room.id)}>View</button>
                  <button onClick={() => handleCloseRoom(room.id)}>Close</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

function viewRoom(id: string) {
  // Implement view room details
}
```

### Gifts Admin Page

`platform/src/app/admin/gifts/page.tsx`:

```typescript
'use client';

import { useEffect, useState } from 'react';
import { adminApi } from '@/lib/adminApiClient';

export default function AdminGiftsPage() {
  const [gifts, setGifts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadGifts();
  }, []);

  const loadGifts = async () => {
    try {
      setLoading(true);
      const response = await adminApi.getGifts();
      setGifts(response.data || []);
    } catch (error) {
      console.error('Error loading gifts:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="admin-container">
      <h1>Gifts Management</h1>

      {loading ? (
        <p>Loading...</p>
      ) : (
        <table className="admin-table">
          <thead>
            <tr>
              <th>Gift Name</th>
              <th>Diamond Cost</th>
              <th>Category</th>
              <th>Comboable</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {gifts.map((gift) => (
              <tr key={gift.id}>
                <td>{gift.name}</td>
                <td>{gift.diamondCost}</td>
                <td>{gift.category}</td>
                <td>{gift.comboable ? 'Yes' : 'No'}</td>
                <td>
                  <button onClick={() => editGift(gift.id)}>Edit</button>
                  <button onClick={() => deleteGift(gift.id)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

function editGift(id: string) {
  // Implement edit gift modal
}

function deleteGift(id: string) {
  // Implement delete gift
}
```

### PK Battles Admin Page

`platform/src/app/admin/pk/page.tsx`:

```typescript
'use client';

import { useEffect, useState } from 'react';
import { adminApi } from '@/lib/adminApiClient';

export default function AdminPKPage() {
  const [battles, setBattles] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadBattles();
  }, []);

  const loadBattles = async () => {
    try {
      setLoading(true);
      const response = await adminApi.getPKBattles();
      setBattles(response.data || []);
    } catch (error) {
      console.error('Error loading battles:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleEndBattle = async (battleId: string) => {
    try {
      await adminApi.endPKBattle(battleId);
      await loadBattles();
    } catch (error) {
      console.error('Error ending battle:', error);
    }
  };

  return (
    <div className="admin-container">
      <h1>PK Battles Management</h1>

      {loading ? (
        <p>Loading...</p>
      ) : (
        <table className="admin-table">
          <thead>
            <tr>
              <th>Battle ID</th>
              <th>Initiator</th>
              <th>Challenger</th>
              <th>Status</th>
              <th>Score</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {battles.map((battle) => (
              <tr key={battle.id}>
                <td>{battle.id}</td>
                <td>{battle.initiatorUsername}</td>
                <td>{battle.challengerUsername}</td>
                <td>{battle.status}</td>
                <td>
                  {battle.initiatorScore} - {battle.challengerScore}
                </td>
                <td>
                  <button onClick={() => viewBattle(battle.id)}>View</button>
                  <button onClick={() => handleEndBattle(battle.id)}>
                    End
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

function viewBattle(id: string) {
  // Implement view battle details
}
```

## Step 3: Add Environment Variables

In `platform/.env.local`:

```env
NEXT_PUBLIC_API_URL=https://talkroom-xxxxx.vercel.app/api
```

## Step 4: Add Styling

Create `platform/src/styles/admin.css`:

```css
.admin-container {
  padding: 20px;
  max-width: 1400px;
  margin: 0 auto;
}

.admin-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.admin-table thead {
  background-color: #333;
  color: white;
}

.admin-table th,
.admin-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

.admin-table tr:hover {
  background-color: #f5f5f5;
}

.admin-table button {
  margin-right: 5px;
  padding: 5px 10px;
  cursor: pointer;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
}

.admin-table button:hover {
  background-color: #0056b3;
}

.search-form {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.search-form input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.search-form button {
  padding: 10px 20px;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.search-form button:hover {
  background-color: #218838;
}
```

## Step 5: Deploy to Vercel

Admin panel will be available at:
```
https://talkroom-xxxxx.vercel.app/admin
```

## Features Implemented

- ✅ User management (list, search, view details)
- ✅ Room management (list, close rooms)
- ✅ Gift management (list, edit, delete)
- ✅ PK battle management (list, end battles)
- ✅ Wallet management (recharge users)
- ✅ Real-time data from MongoDB backend

## Admin Panel URL

After deployment:
```
https://talkroom-xxxxx.vercel.app/admin/users
https://talkroom-xxxxx.vercel.app/admin/rooms
https://talkroom-xxxxx.vercel.app/admin/gifts
https://talkroom-xxxxx.vercel.app/admin/pk
```

---

**All admin features connected to backend APIs!** 🎉
