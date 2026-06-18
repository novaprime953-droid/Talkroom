import { NextResponse } from "next/server";
import { pkBattles } from "@/lib/data";

export function GET() {
  return NextResponse.json({ battles: pkBattles });
}
