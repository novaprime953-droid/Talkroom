import { NextResponse } from "next/server";
import { rooms } from "@/lib/data";

export function GET() {
  return NextResponse.json({ rooms });
}

export async function POST(request: Request) {
  const body = await request.json();
  return NextResponse.json({ ok: true, room: { id: `r${Date.now()}`, ...body } });
}
