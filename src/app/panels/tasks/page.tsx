import { PanelShell } from "../panel-shell";

export default function TasksPage() {
  const tasks = [
    { task: "Go live for 30 minutes", reward: "200 coins", done: true },
    { task: "Send 5 gifts", reward: "150 coins", done: false },
    { task: "Win a PK battle", reward: "500 coins", done: false },
  ];

  return (
    <PanelShell title="Task Center">
      <div style={{ display: "grid", gap: 12 }}>
        {tasks.map((t) => (
          <div key={t.task} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: 12, borderBottom: "1px solid rgba(148,163,184,0.1)" }}>
            <div>
              <div>{t.task}</div>
              <div style={{ color: "#fbbf24", fontSize: 13 }}>{t.reward}</div>
            </div>
            <span className="badge">{t.done ? "Done" : "Claim"}</span>
          </div>
        ))}
      </div>
    </PanelShell>
  );
}
