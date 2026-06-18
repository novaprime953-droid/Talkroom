import Link from "next/link";

const nav = [
  { href: "/admin", label: "Dashboard" },
  { href: "/admin/rooms", label: "Rooms" },
  { href: "/admin/gifts", label: "Gifts" },
  { href: "/admin/vip", label: "VIP / SVIP" },
  { href: "/admin/users", label: "Users" },
  { href: "/admin/pk", label: "PK Battles" },
];

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ display: "flex", minHeight: "100vh" }}>
      <aside className="glass" style={{ width: 240, padding: 20, margin: 16, flexShrink: 0 }}>
        <div style={{ fontWeight: 700, marginBottom: 24, color: "#14b8a6" }}>Talk Room Admin</div>
        <nav style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          {nav.map((item) => (
            <Link key={item.href} href={item.href} style={{ padding: "8px 12px", borderRadius: 8 }}>
              {item.label}
            </Link>
          ))}
        </nav>
        <div style={{ marginTop: 24 }}>
          <Link href="/">← Platform Home</Link>
        </div>
      </aside>
      <main style={{ flex: 1, padding: 24 }}>{children}</main>
    </div>
  );
}
