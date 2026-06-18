import { PanelShell } from "../panel-shell";

export default function HelpPage() {
  return (
    <PanelShell title="Help & Support">
      <p>FAQ, ticket submission, and live support chat.</p>
      <button className="btn" type="button">Contact Support</button>
      <div style={{ marginTop: 20, color: "#94a3b8", fontSize: 14 }}>
        <p>• How to recharge coins?</p>
        <p>• What is SVIP entry effect?</p>
        <p>• PK battle rules</p>
      </div>
    </PanelShell>
  );
}
