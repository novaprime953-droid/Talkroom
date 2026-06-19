import { PanelShell } from "../panel-shell";

export default function TasksPage() {
  const dailyTasks = [
    {
      id: 1,
      emoji: "🎤",
      title: "Go live for 30 minutes",
      description: "Broadcast in a voice room",
      reward: "500 coins",
      progress: 20,
      requirement: 30,
      done: false,
    },
    {
      id: 2,
      emoji: "🎁",
      title: "Send 5 gifts",
      description: "Send gifts to other users",
      reward: "300 coins",
      progress: 3,
      requirement: 5,
      done: false,
    },
    {
      id: 3,
      emoji: "👑",
      title: "Win a PK battle",
      description: "Defeat opponent in PK",
      reward: "800 coins",
      progress: 0,
      requirement: 1,
      done: false,
    },
    {
      id: 4,
      emoji: "💎",
      title: "Try Lucky Gifts",
      description: "Send 2 lucky gifts",
      reward: "400 coins",
      progress: 1,
      requirement: 2,
      done: false,
    },
    {
      id: 5,
      emoji: "👥",
      title: "Make 3 friends",
      description: "Follow 3 users",
      reward: "200 coins",
      progress: 3,
      requirement: 3,
      done: true,
    },
  ];

  const weeklyTasks = [
    {
      id: 101,
      emoji: "🏆",
      title: "Win 5 PK battles",
      description: "Participate in PK battles",
      reward: "3,000 coins",
      progress: 2,
      requirement: 5,
      done: false,
    },
    {
      id: 102,
      emoji: "💰",
      title: "Spend 10,000 coins",
      description: "Send gifts and items",
      reward: "2,000 coins",
      progress: 7500,
      requirement: 10000,
      done: false,
    },
    {
      id: 103,
      emoji: "⭐",
      title: "Reach 100 followers",
      description: "Build your community",
      reward: "1,500 coins + 100 VIP points",
      progress: 85,
      requirement: 100,
      done: false,
    },
  ];

  const taskRewards = [
    { day: "Day 1", reward: "200 coins", claimed: true },
    { day: "Day 2", reward: "300 coins", claimed: true },
    { day: "Day 3", reward: "500 coins", claimed: false },
    { day: "Day 4", reward: "1,000 coins", claimed: false },
    { day: "Day 5", reward: "VIP Pass", claimed: false },
    { day: "Day 6", reward: "2,000 coins", claimed: false },
    { day: "Day 7", reward: "Legendary Frame", claimed: false },
  ];

  return (
    <PanelShell title="Task Center">
      {/* Daily Tasks */}
      <div style={{ marginBottom: 32 }}>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>📅 Daily Tasks</h3>
        <div style={{ display: "grid", gap: 12 }}>
          {dailyTasks.map((task) => (
            <div key={task.id} className="glass" style={{ padding: 12 }}>
              <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
                <div style={{ display: "flex", gap: 8, alignItems: "flex-start" }}>
                  <span style={{ fontSize: "20px" }}>{task.emoji}</span>
                  <div>
                    <div style={{ fontSize: "13px", fontWeight: "700" }}>{task.title}</div>
                    <div style={{ fontSize: "11px", color: "#94a3b8" }}>{task.description}</div>
                  </div>
                </div>
                <div style={{ fontSize: "12px", fontWeight: "700", color: "#fbbf24" }}>{task.reward}</div>
              </div>
              <div style={{ background: "rgba(148,163,184,0.1)", borderRadius: 8, height: 6, overflow: "hidden" }}>
                <div style={{
                  background: "linear-gradient(90deg, #06b6d4, #0ea5e9)",
                  height: "100%",
                  width: `${(task.progress / task.requirement) * 100}%`,
                  transition: "width 0.3s ease",
                }} />
              </div>
              <div style={{ fontSize: "10px", color: "#94a3b8", marginTop: 4 }}>
                {task.progress}/{task.requirement}
              </div>
              {task.done && (
                <button className="btn" style={{ width: "100%", marginTop: 8, background: "#22c55e" }} type="button">
                  ✓ Completed
                </button>
              )}
            </div>
          ))}
        </div>
      </div>

      {/* Weekly Tasks */}
      <div style={{ marginBottom: 32 }}>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>📊 Weekly Challenges</h3>
        <div style={{ display: "grid", gap: 12 }}>
          {weeklyTasks.map((task) => (
            <div key={task.id} className="glass" style={{ padding: 12, borderLeft: "3px solid #8b5cf6" }}>
              <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
                <div style={{ display: "flex", gap: 8, alignItems: "flex-start" }}>
                  <span style={{ fontSize: "20px" }}>{task.emoji}</span>
                  <div>
                    <div style={{ fontSize: "13px", fontWeight: "700" }}>{task.title}</div>
                    <div style={{ fontSize: "11px", color: "#94a3b8" }}>{task.description}</div>
                  </div>
                </div>
              </div>
              <div style={{ background: "rgba(148,163,184,0.1)", borderRadius: 8, height: 6, overflow: "hidden", marginBottom: 4 }}>
                <div style={{
                  background: "linear-gradient(90deg, #8b5cf6, #a78bfa)",
                  height: "100%",
                  width: `${(task.progress / task.requirement) * 100}%`,
                }} />
              </div>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <div style={{ fontSize: "10px", color: "#94a3b8" }}>
                  {task.progress}/{task.requirement}
                </div>
                <div style={{ fontSize: "12px", fontWeight: "700", color: "#fbbf24" }}>{task.reward}</div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* 7-Day Reward */}
      <div>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>🎁 7-Day Sign-In Rewards</h3>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)", gap: 8 }}>
          {taskRewards.map((reward, i) => (
            <div
              key={i}
              className="glass"
              style={{
                padding: 10,
                textAlign: "center",
                background: reward.claimed ? "rgba(34, 197, 94, 0.1)" : "rgba(148, 163, 184, 0.05)",
                border: reward.claimed ? "1px solid #22c55e" : undefined,
                opacity: reward.claimed ? 0.8 : 1,
              }}
            >
              <div style={{ fontSize: "18px", marginBottom: 4 }}>
                {i === 6 ? "👑" : "🎁"}
              </div>
              <div style={{ fontSize: "9px", fontWeight: "700", marginBottom: 4 }}>{reward.day}</div>
              <div style={{ fontSize: "9px", color: "#94a3b8", marginBottom: 6 }}>{reward.reward}</div>
              <button
                className="btn"
                style={{
                  width: "100%",
                  padding: "4px 0",
                  fontSize: "10px",
                  background: reward.claimed ? "#22c55e" : undefined,
                }}
                type="button"
                disabled={reward.claimed}
              >
                {reward.claimed ? "✓" : "Claim"}
              </button>
            </div>
          ))}
        </div>
      </div>
    </PanelShell>
  );
}
