import { rooms, gifts, pkBattles, micUsers, conversations } from "@/lib/data";

export default function AdminDashboard() {
  const stats = [
    { label: "Live Rooms", value: rooms.filter((r) => r.isLive).length },
    { label: "Gifts", value: gifts.length },
    { label: "PK Battles", value: pkBattles.length },
    { label: "Active Users", value: micUsers.length },
    { label: "Unread Chats", value: conversations.reduce((a, c) => a + c.unread, 0) },
  ];

  return (
    <div>
      <h1>Dashboard</h1>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit,minmax(160px,1fr))", gap: 16, marginBottom: 32 }}>
        {stats.map((s) => (
          <div key={s.label} className="glass" style={{ padding: 20 }}>
            <div style={{ color: "#94a3b8", fontSize: 13 }}>{s.label}</div>
            <div style={{ fontSize: 32, fontWeight: 700 }}>{s.value}</div>
          </div>
        ))}
      </div>
      <div className="glass" style={{ padding: 20 }}>
        <h2>Quick Actions</h2>
        <p style={{ color: "#94a3b8" }}>Manage rooms, gifts, VIP tiers, and PK events from the sidebar panels.</p>
      </div>
    </div>
  );
}
