import { currentUser, micUsers } from "@/lib/data";

export default function AdminUsersPage() {
  const users = [currentUser, ...micUsers];

  return (
    <div>
      <h1>Users</h1>
      <div className="glass" style={{ padding: 16 }}>
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>VIP</th>
              <th>Level</th>
              <th>Coins</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id}>
                <td>{user.name}</td>
                <td><span className="badge gold">Tier {user.vipTier}</span></td>
                <td>{user.level}</td>
                <td>{user.coins.toLocaleString()}</td>
                <td>{user.isOnline ? <span className="badge live">Online</span> : "Offline"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
