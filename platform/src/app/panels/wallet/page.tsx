import { PanelShell } from "../panel-shell";

export default function WalletPage() {
  const wallet = {
    coins: 128500,
    diamonds: 450,
    vipPoints: 3200,
    totalSpent: 250000,
    totalEarned: 180000,
  };

  const transactions = [
    { id: 1, type: "Gift", amount: -500, desc: "Sent Rose gift", time: "2h ago" },
    { id: 2, type: "Recharge", amount: 5000, desc: "Recharge $49.99", time: "1d ago" },
    { id: 3, type: "PK Win", amount: 1200, desc: "PK Battle reward", time: "2d ago" },
    { id: 4, type: "Lucky Gift", amount: 3500, desc: "Lucky Gift win (7x)", time: "3d ago" },
    { id: 5, type: "Task", amount: 200, desc: "Daily task complete", time: "4d ago" },
  ];

  const coinPackages = [
    { coins: 500, price: "$4.99", bonus: 0 },
    { coins: 2500, price: "$19.99", bonus: 500, popular: true },
    { coins: 10000, price: "$69.99", bonus: 2000 },
    { coins: 50000, price: "$299.99", bonus: 15000 },
  ];

  return (
    <PanelShell title="Wallet & Recharge">
      {/* Balance Section */}
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 12, marginBottom: 24 }}>
        <div className="glass" style={{ padding: 16, textAlign: "center" }}>
          <div style={{ fontSize: "12px", color: "#94a3b8", marginBottom: 4 }}>Coins</div>
          <div style={{ fontSize: "20px", fontWeight: "900", color: "#fbbf24" }}>
            {wallet.coins.toLocaleString()}
          </div>
        </div>
        <div className="glass" style={{ padding: 16, textAlign: "center" }}>
          <div style={{ fontSize: "12px", color: "#94a3b8", marginBottom: 4 }}>Diamonds</div>
          <div style={{ fontSize: "20px", fontWeight: "900", color: "#ec4899" }}>
            {wallet.diamonds.toLocaleString()}
          </div>
        </div>
        <div className="glass" style={{ padding: 16, textAlign: "center" }}>
          <div style={{ fontSize: "12px", color: "#94a3b8", marginBottom: 4 }}>VIP Points</div>
          <div style={{ fontSize: "20px", fontWeight: "900", color: "#06b6d4" }}>
            {wallet.vipPoints.toLocaleString()}
          </div>
        </div>
      </div>

      {/* Stats */}
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12, marginBottom: 24 }}>
        <div className="glass" style={{ padding: 12 }}>
          <div style={{ fontSize: "12px", color: "#94a3b8" }}>Total Spent</div>
          <div style={{ fontSize: "16px", fontWeight: "700", color: "#64748b" }}>
            {(wallet.totalSpent / 1000).toFixed(1)}K
          </div>
        </div>
        <div className="glass" style={{ padding: 12 }}>
          <div style={{ fontSize: "12px", color: "#94a3b8" }}>Total Earned</div>
          <div style={{ fontSize: "16px", fontWeight: "700", color: "#22c55e" }}>
            {(wallet.totalEarned / 1000).toFixed(1)}K
          </div>
        </div>
      </div>

      {/* Coin Packages */}
      <div style={{ marginBottom: 24 }}>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>🛍️ Recharge Coins</h3>
        <div style={{ display: "grid", gap: 10 }}>
          {coinPackages.map((pkg, i) => (
            <button
              key={i}
              className="btn"
              style={{
                width: "100%",
                justifyContent: "space-between",
                position: "relative",
                background: pkg.popular ? "linear-gradient(135deg, #ec489952, #f972b652)" : undefined,
                border: pkg.popular ? "1px solid #f43f5e" : undefined,
              }}
              type="button"
            >
              <span>
                💰 {pkg.coins.toLocaleString()} coins
                {pkg.bonus > 0 && <span style={{ color: "#22c55e", marginLeft: 8 }}>+{pkg.bonus} bonus</span>}
              </span>
              <span style={{ fontWeight: "700" }}>{pkg.price}</span>
              {pkg.popular && (
                <span style={{
                  position: "absolute",
                  top: "-10px",
                  right: "10px",
                  background: "linear-gradient(135deg, #f43f5e, #f972b6)",
                  color: "white",
                  fontSize: "10px",
                  padding: "2px 8px",
                  borderRadius: "4px",
                  fontWeight: "700",
                }}>
                  POPULAR
                </span>
              )}
            </button>
          ))}
        </div>
      </div>

      {/* Transaction History */}
      <div>
        <h3 style={{ marginBottom: 12, fontSize: "16px", fontWeight: "700" }}>📊 Recent Transactions</h3>
        <div style={{ display: "grid", gap: 10 }}>
          {transactions.map((tx) => (
            <div key={tx.id} className="glass" style={{ padding: 12, display: "flex", justifyContent: "space-between", alignItems: "center" }}>
              <div>
                <div style={{ fontSize: "13px", fontWeight: "700" }}>{tx.type}</div>
                <div style={{ fontSize: "11px", color: "#94a3b8" }}>{tx.desc}</div>
                <div style={{ fontSize: "10px", color: "#64748b" }}>{tx.time}</div>
              </div>
              <div style={{
                fontSize: "14px",
                fontWeight: "700",
                color: tx.amount > 0 ? "#22c55e" : "#f43f5e",
              }}>
                {tx.amount > 0 ? "+" : ""}{tx.amount.toLocaleString()}
              </div>
            </div>
          ))}
        </div>
      </div>
    </PanelShell>
  );
}
