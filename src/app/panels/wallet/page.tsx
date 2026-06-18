import { PanelShell } from "../panel-shell";

export default function WalletPage() {
  return (
    <PanelShell title="Wallet & Recharge">
      <p>Balance: <strong style={{ color: "#fbbf24" }}>128,500 coins</strong></p>
      <div style={{ display: "grid", gap: 12, marginTop: 16 }}>
        {["500 coins — $4.99", "2,500 coins — $19.99", "10,000 coins — $69.99", "VIP Pack — $29.99"].map((pack) => (
          <button key={pack} className="btn" style={{ width: "100%", justifyContent: "center" }} type="button">{pack}</button>
        ))}
      </div>
    </PanelShell>
  );
}
