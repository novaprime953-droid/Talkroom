import { NextResponse } from "next/server";
import { gifts } from "@/lib/data";

export function GET() {
  return NextResponse.json({ gifts });
}
