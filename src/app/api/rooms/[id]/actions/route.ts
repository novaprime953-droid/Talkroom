import { NextRequest, NextResponse } from 'next/server';
import { RoomService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * POST /api/rooms/[id]/actions - Perform room actions (leave, mic, promote, mute, close)
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const body = await request.json();
    const { action, userId, status, targetUserId } = body;

    if (!action) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing action'),
        { status: 400 }
      );
    }

    let result: any;

    if (action === 'leave') {
      if (!userId) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId'),
          { status: 400 }
        );
      }
      result = await RoomService.leaveRoom(params.id, userId);
    } else if (action === 'mic') {
      if (!userId || status === undefined) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId or status'),
          { status: 400 }
        );
      }
      result = await RoomService.updateMicStatus(params.id, userId, status);
    } else if (action === 'promote') {
      if (!userId || !targetUserId) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId or targetUserId'),
          { status: 400 }
        );
      }
      result = await RoomService.promoteMember(params.id, targetUserId);
    } else if (action === 'mute') {
      if (!userId || !targetUserId || status === undefined) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId, targetUserId, or status'),
          { status: 400 }
        );
      }
      result = await RoomService.muteMember(params.id, targetUserId, status);
    } else if (action === 'close') {
      if (!userId) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId'),
          { status: 400 }
        );
      }
      result = await RoomService.closeRoom(params.id);
    } else {
      return NextResponse.json(
        errorResponse('INVALID_ACTION', 'Unknown action'),
        { status: 400 }
      );
    }

    return NextResponse.json(
      successResponse(result, `Room action '${action}' completed`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('ACTION_FAILED', 'Failed to perform action'),
      { status: 500 }
    );
  }
}
