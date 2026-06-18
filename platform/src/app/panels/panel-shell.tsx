export function PanelShell({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <main style={{ maxWidth: 720, margin: "0 auto", padding: "32px 20px" }}>
      <h1 style={{ marginBottom: 8 }}>{title}</h1>
      <p style={{ color: "#94a3b8", marginBottom: 24 }}>Talk Room Web Panel — opened from mobile app WebView</p>
      <div className="glass" style={{ padding: 24 }}>{children}</div>
    </main>
  );
}
