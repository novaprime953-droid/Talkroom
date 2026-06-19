import { NextRequest, NextResponse } from 'next/server';
import { RoomService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/messages - Get messages (can filter by roomId)
 */
export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const roomId = searchParams.get('roomId');
    const limit = parseInt(searchParams.get('limit') || '50');

    if (!roomId) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'roomId is required'),
        { status: 400 }
      );
    }

    const messages = await RoomService.getRoomMessages(roomId, limit);

    return NextResponse.json(
      successResponse(messages, `Retrieved ${messages.length} messages`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch messages'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/messages - Send message to room
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { roomId, userId, username, content, avatar } = body;

    if (!roomId || !userId || !username || !content) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing required fields'),
        { status: 400 }
      );
    }

    const message = await RoomService.sendMessage(
      roomId,
      userId,
      username,
      content,
      avatar
    );

    return NextResponse.json(
      successResponse(message, 'Message sent'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('SEND_FAILED', 'Failed to send message'),
      { status: 500 }
    );
  }
}
