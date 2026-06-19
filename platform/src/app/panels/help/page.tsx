import { PanelShell } from "../panel-shell";

export default function HelpPage() {
  const faqs = [
    {
      q: "How do I recharge coins?",
      a: "Go to Wallet panel → Tap coin package → Complete payment. Coins are credited instantly.",
    },
    {
      q: "What's the difference between Coins and Diamonds?",
      a: "Coins are earned/purchased for gifting. Diamonds are premium currency for exclusive items and VIP upgrades.",
    },
    {
      q: "How does SVIP membership work?",
      a: "SVIP gives exclusive perks: entry animations, badges, room priority, and bonus coins. Upgrade in VIP panel.",
    },
    {
      q: "What are Lucky Gifts?",
      a: "Lucky Gifts have multipliers - send 50 coins, win up to 500! Jackpot increases daily.",
    },
    {
      q: "How do PK battles work?",
      a: "2 players compete for 180 seconds. Score points by receiving gifts. First to higher score wins and gets rewards.",
    },
    {
      q: "Can I get a refund?",
      a: "Refunds are available within 48 hours if content wasn't used. Contact support.",
    },
    {
      q: "What if my account got hacked?",
      a: "Change password immediately and contact support with proof of ownership.",
    },
    {
      q: "How do I report inappropriate content?",
      a: "Tap menu on any room/user → Report → Select reason. We review within 24 hours.",
    },
    {
      q: "Can I transfer coins to another account?",
      a: "Coins are account-specific and non-transferable. Gifts sent are permanent.",
    },
    {
      q: "What's the max level?",
      a: "Max level is 999. Each level requires more XP and unlocks new features.",
    },
  ];

  const guides = [
    {
      title: "Getting Started",
      emoji: "🚀",
      steps: [
        "Create profile & upload avatar",
        "Complete daily tasks to earn coins",
        "Join a voice room and chat",
        "Send gifts to make friends",
      ],
    },
    {
      title: "Maximize Earnings",
      emoji: "💰",
      steps: [
        "Host rooms regularly",
        "Complete all daily + weekly tasks",
        "Win PK battles for rewards",
        "Refer friends for bonus",
      ],
    },
    {
      title: "VIP Benefits",
      emoji: "👑",
      steps: [
        "Choose your VIP tier",
        "Get exclusive animations & badges",
        "Room entry priority",
        "Monthly rewards & perks",
      ],
    },
    {
      title: "Safe Trading",
      emoji: "🛡️",
      steps: [
        "Never share password",
        "Use in-app verification only",
        "Report suspicious accounts",
        "Enable 2-factor authentication",
      ],
    },
  ];

  return (
    <PanelShell title="Help & Support">
      {/* Quick Support */}
      <div style={{ marginBottom: 24, display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12 }}>
        <button className="btn" style={{ justifyContent: "center" }} type="button">
          💬 Live Chat
        </button>
        <button className="btn" style={{ justifyContent: "center" }} type="button">
          📧 Email Support
        </button>
      </div>

      {/* Guides */}
      <div style={{ marginBottom: 24 }}>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>📚 Quick Guides</h3>
        <div style={{ display: "grid", gap: 12 }}>
          {guides.map((guide, i) => (
            <details key={i} style={{ cursor: "pointer" }}>
              <summary style={{
                padding: 12,
                background: "rgba(148,163,184,0.05)",
                borderRadius: 8,
                fontWeight: "700",
                display: "flex",
                alignItems: "center",
                gap: 8,
              }}>
                <span style={{ fontSize: "18px" }}>{guide.emoji}</span>
                {guide.title}
              </summary>
              <div style={{ padding: "12px 12px 0", marginLeft: 26 }}>
                {guide.steps.map((step, j) => (
                  <div key={j} style={{ display: "flex", gap: 8, marginBottom: 8, alignItems: "flex-start" }}>
                    <span style={{ color: "#06b6d4", fontWeight: "700" }}>{j + 1}.</span>
                    <span style={{ color: "#94a3b8" }}>{step}</span>
                  </div>
                ))}
              </div>
            </details>
          ))}
        </div>
      </div>

      {/* FAQs */}
      <div>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>❓ Frequently Asked Questions</h3>
        <div style={{ display: "grid", gap: 10 }}>
          {faqs.map((faq, i) => (
            <details key={i} style={{ cursor: "pointer" }}>
              <summary style={{
                padding: 12,
                background: "rgba(148,163,184,0.08)",
                borderRadius: 8,
                fontWeight: "600",
              }}>
                Q: {faq.q}
              </summary>
              <div style={{ padding: 12, marginTop: -1, background: "rgba(148,163,184,0.04)", borderRadius: "0 0 8px 8px", color: "#94a3b8" }}>
                A: {faq.a}
              </div>
            </details>
          ))}
        </div>
      </div>

      {/* Contact Info */}
      <div style={{ marginTop: 24, padding: 16, background: "rgba(6,182,212,0.1)", borderRadius: 12, textAlign: "center" }}>
        <div style={{ fontSize: "13px", fontWeight: "700", marginBottom: 8 }}>📞 Still need help?</div>
        <div style={{ fontSize: "12px", color: "#94a3b8", marginBottom: 12 }}>
          Contact us anytime. Average response time: 2 hours
        </div>
        <div style={{ fontSize: "11px", color: "#64748b" }}>
          Email: support@talkroom.app | Discord: discord.gg/talkroom
        </div>
      </div>
    </PanelShell>
  );
}
