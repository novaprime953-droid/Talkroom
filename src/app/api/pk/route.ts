import { NextRequest, NextResponse } from 'next/server';
import { PKService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/pk - Get PK battles
 */
export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const userId = searchParams.get('userId');
    const roomId = searchParams.get('roomId');

    let battles: any[];

    if (roomId) {
      battles = await PKService.getActiveBattlesInRoom(roomId);
    } else if (userId) {
      battles = await PKService.getPendingBattles(userId);
    } else {
      battles = [];
    }

    return NextResponse.json(
      successResponse(battles, `Retrieved ${battles.length} battles`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch battles'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/pk - Initiate PK battle
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { roomId, initiatorId, initiatorUsername, challengerId, challengerUsername } = body;

    if (!roomId || !initiatorId || !initiatorUsername || !challengerId || !challengerUsername) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing required fields'),
        { status: 400 }
      );
    }

    const battle = await PKService.initiateBattle(
      roomId,
      initiatorId,
      initiatorUsername,
      challengerId,
      challengerUsername
    );

    return NextResponse.json(
      successResponse(battle, 'Battle initiated'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('CREATE_FAILED', 'Failed to create battle'),
      { status: 500 }
    );
  }
}
