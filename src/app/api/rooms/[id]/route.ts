import { NextRequest, NextResponse } from 'next/server';
import { RoomService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/rooms/[id] - Get room details
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const room = await RoomService.getRoomById(params.id);
    
    if (!room) {
      return NextResponse.json(
        errorResponse('NOT_FOUND', 'Room not found'),
        { status: 404 }
      );
    }

    const messages = await RoomService.getRoomMessages(params.id, 50);
    
    return NextResponse.json(
      successResponse({ room, messages }, 'Room details retrieved')
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch room'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/rooms/[id]/join - Join a room
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const body = await request.json();
    const { userId, username, avatar } = body;

    if (!userId || !username) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing userId or username'),
        { status: 400 }
      );
    }

    const joined = await RoomService.joinRoom(params.id, userId, username, avatar);

    if (!joined) {
      return NextResponse.json(
        errorResponse('JOIN_FAILED', 'Could not join room'),
        { status: 400 }
      );
    }

    const room = await RoomService.getRoomById(params.id);
    
    return NextResponse.json(
      successResponse(room, 'Joined room successfully'),
      { status: 200 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('JOIN_FAILED', 'Failed to join room'),
      { status: 500 }
    );
  }
}
