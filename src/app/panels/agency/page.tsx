import { PanelShell } from "../panel-shell";

export default function AgencyPage() {
  return (
    <PanelShell title="Agency Center">
      <p>Hosts this week: <strong>24</strong></p>
      <p>Total revenue: <strong style={{ color: "#14b8a6" }}>$12,480</strong></p>
      <p style={{ color: "#94a3b8" }}>Manage host roster, payouts, and performance from this panel.</p>
    </PanelShell>
  );
}
