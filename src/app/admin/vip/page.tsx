import { vipTiers } from "@/lib/data";

export default function AdminVipPage() {
  return (
    <div>
      <h1>VIP / SVIP Tiers</h1>
      <div style={{ display: "grid", gap: 16 }}>
        {vipTiers.map((tier) => (
          <div key={tier.tier} className="glass" style={{ padding: 20, display: "flex", alignItems: "center", gap: 20 }}>
            <div style={{ width: 48, height: 48, borderRadius: 12, background: tier.frameColor, display: "flex", alignItems: "center", justifyContent: "center", fontWeight: 700 }}>
              {tier.tier}
            </div>
            <div>
              <strong>{tier.name}</strong>
              <div style={{ color: "#94a3b8", fontSize: 13 }}>Entry: {tier.entryAsset}</div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
