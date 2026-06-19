import { NextRequest, NextResponse } from 'next/server';
import { PKService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/pk/[id] - Get battle details or stats
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const stats = searchParams.get('stats');

    if (stats) {
      // Get user PK stats
      const battleStats = await PKService.getBattleStats(params.id);
      return NextResponse.json(
        successResponse(battleStats, 'Battle stats retrieved')
      );
    }

    // Get specific battle
    const battle = await PKService.getBattle(params.id);

    if (!battle) {
      return NextResponse.json(
        errorResponse('NOT_FOUND', 'Battle not found'),
        { status: 404 }
      );
    }

    return NextResponse.json(
      successResponse(battle, 'Battle retrieved')
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch battle'),
      { status: 500 }
    );
  }
}

/**
 * PUT /api/pk/[id] - Update battle (accept, reject, score, end)
 */
export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const body = await request.json();
    const { action, userId, scoreIncrease } = body;

    if (!action) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing action'),
        { status: 400 }
      );
    }

    let result: any;

    if (action === 'accept') {
      result = await PKService.acceptBattle(params.id);
    } else if (action === 'reject') {
      result = await PKService.rejectBattle(params.id);
    } else if (action === 'updateScore') {
      if (!userId || scoreIncrease === undefined) {
        return NextResponse.json(
          errorResponse('INVALID_REQUEST', 'Missing userId or scoreIncrease'),
          { status: 400 }
        );
      }
      result = await PKService.updateScore(params.id, userId, scoreIncrease);
    } else if (action === 'end') {
      result = await PKService.endBattle(params.id);
    } else {
      return NextResponse.json(
        errorResponse('INVALID_ACTION', 'Unknown action'),
        { status: 400 }
      );
    }

    return NextResponse.json(
      successResponse(result, `Battle ${action} successful`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('UPDATE_FAILED', 'Failed to update battle'),
      { status: 500 }
    );
  }
}
