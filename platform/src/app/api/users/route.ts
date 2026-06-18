import { NextResponse } from "next/server";
import { currentUser, micUsers } from "@/lib/data";

export function GET() {
  return NextResponse.json({ currentUser, micUsers });
}
