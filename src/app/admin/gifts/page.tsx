import { gifts } from "@/lib/data";

export default function AdminGiftsPage() {
  return (
    <div>
      <h1>Gift Catalog</h1>
      <div className="glass" style={{ padding: 16 }}>
        <table>
          <thead>
            <tr>
              <th>Gift</th>
              <th>Category</th>
              <th>Price</th>
              <th>Animation</th>
            </tr>
          </thead>
          <tbody>
            {gifts.map((gift) => (
              <tr key={gift.id}>
                <td>{gift.emoji} {gift.name}</td>
                <td><span className="badge">{gift.category}</span></td>
                <td>{gift.price.toLocaleString()} coins</td>
                <td style={{ fontSize: 12, color: "#94a3b8" }}>
                  {gift.svgaAsset ?? gift.lottieAsset ?? "—"}
                  {gift.isLucky && ` · x${gift.multiplier}`}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
