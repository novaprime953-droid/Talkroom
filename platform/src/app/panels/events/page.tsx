import { PanelShell } from "../panel-shell";

export default function EventsPage() {
  const events = [
    { name: "Lucky Gift Jackpot", status: "Live", reward: "Up to 1000x" },
    { name: "SVIP Carnival", status: "Live", reward: "Exclusive frames" },
    { name: "PK Championship", status: "Soon", reward: "50,000 coins" },
  ];

  return (
    <PanelShell title="Events Center">
      <div style={{ display: "grid", gap: 12 }}>
        {events.map((e) => (
          <div key={e.name} style={{ padding: 16, border: "1px solid rgba(148,163,184,0.15)", borderRadius: 12 }}>
            <strong>{e.name}</strong>
            <div style={{ color: "#94a3b8", fontSize: 14 }}>{e.reward}</div>
            <span className="badge live" style={{ marginTop: 8 }}>{e.status}</span>
          </div>
        ))}
      </div>
    </PanelShell>
  );
}
