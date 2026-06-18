import { pkBattles } from "@/lib/data";

export default function AdminPkPage() {
  return (
    <div>
      <h1>PK Battles</h1>
      <div style={{ display: "grid", gap: 16 }}>
        {pkBattles.map((pk) => (
          <div key={pk.id} className="glass" style={{ padding: 20 }}>
            <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 12 }}>
              <strong>{pk.leftName} vs {pk.rightName}</strong>
              <span className={`badge ${pk.status === "live" ? "live" : ""}`}>{pk.status}</span>
            </div>
            <div style={{ color: "#94a3b8" }}>Score: {pk.leftScore} — {pk.rightScore}</div>
            <div style={{ fontSize: 13, color: "#64748b" }}>Room: {pk.roomId}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
