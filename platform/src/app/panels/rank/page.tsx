import { PanelShell } from "../panel-shell";

export default function RankPage() {
  const ranks = [
    { rank: 1, name: "Luna Beats", score: "2.4M" },
    { rank: 2, name: "Thunder King", score: "1.9M" },
    { rank: 3, name: "Nova Star", score: "1.2M" },
  ];

  return (
    <PanelShell title="Leaderboards">
      <table>
        <thead>
          <tr><th>#</th><th>User</th><th>Score</th></tr>
        </thead>
        <tbody>
          {ranks.map((r) => (
            <tr key={r.rank}>
              <td>{r.rank}</td>
              <td>{r.name}</td>
              <td>{r.score}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </PanelShell>
  );
}
