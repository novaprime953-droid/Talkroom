import { NextResponse } from "next/server";
import { conversations, roomMessages } from "@/lib/data";

export function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const type = searchParams.get("type");

  if (type === "conversations") {
    return NextResponse.json({ conversations });
  }

  return NextResponse.json({ messages: roomMessages });
}
