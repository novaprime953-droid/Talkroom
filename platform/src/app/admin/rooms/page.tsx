import { rooms } from "@/lib/data";

export default function AdminRoomsPage() {
  return (
    <div>
      <h1>Voice Rooms</h1>
      <div className="glass" style={{ padding: 16 }}>
        <table>
          <thead>
            <tr>
              <th>Title</th>
              <th>Host</th>
              <th>Category</th>
              <th>Listeners</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            {rooms.map((room) => (
              <tr key={room.id}>
                <td>{room.title}</td>
                <td>{room.hostName}</td>
                <td>{room.category}</td>
                <td>{room.listeners.toLocaleString()}</td>
                <td>
                  {room.isLive ? <span className="badge live">LIVE</span> : <span className="badge">Offline</span>}
                  {room.isPk && <span className="badge gold" style={{ marginLeft: 8 }}>PK</span>}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
