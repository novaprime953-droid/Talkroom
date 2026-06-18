import Link from "next/link";
import { rooms, gifts, pkBattles, webPanels } from "@/lib/data";

export default function HomePage() {
  return (
    <main style={{ maxWidth: 960, margin: "0 auto", padding: "48px 24px" }}>
      <header style={{ marginBottom: 40 }}>
        <h1 style={{ fontSize: 40, margin: "0 0 8px", background: "linear-gradient(90deg,#14b8a6,#fbbf24)", WebkitBackgroundClip: "text", color: "transparent" }}>
          Talk Room Platform
        </h1>
        <p style={{ color: "#94a3b8", margin: 0 }}>API backend + web panels for the Talk Room mobile app</p>
      </header>

      <section className="glass" style={{ padding: 24, marginBottom: 24 }}>
        <h2>API Status</h2>
        <p>Live endpoints ready for Flutter app integration:</p>
        <ul>
          <li><Link href="/api/config">/api/config</Link> — app config & panel URLs</li>
          <li><Link href="/api/rooms">/api/rooms</Link> — voice rooms ({rooms.length})</li>
          <li><Link href="/api/gifts">/api/gifts</Link> — gift catalog ({gifts.length})</li>
          <li><Link href="/api/users">/api/users</Link> — users & profile</li>
          <li><Link href="/api/messages">/api/messages</Link> — chat messages</li>
          <li><Link href="/api/pk">/api/pk</Link> — PK battles ({pkBattles.length})</li>
        </ul>
        <Link className="btn" href="/admin">Open Admin Panel →</Link>
      </section>

      <section className="glass" style={{ padding: 24 }}>
        <h2>Web Panels (in-app WebView)</h2>
        <div style={{ display: "grid", gap: 12 }}>
          {webPanels.map((panel) => (
            <Link key={panel.id} href={panel.path} className="glass" style={{ padding: 16, display: "block" }}>
              <strong>{panel.name}</strong>
              <div style={{ color: "#94a3b8", fontSize: 14 }}>{panel.description}</div>
            </Link>
          ))}
        </div>
      </section>
    </main>
  );
}
