import { NextRequest, NextResponse } from 'next/server';
import { WalletService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/wallet - Get wallet statistics (requires auth)
 */
export async function GET() {
  try {
    return NextResponse.json(
      successResponse(
        { message: 'Use GET /api/wallet/[userId] to fetch specific wallet' },
        'Wallet endpoint ready'
      )
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch wallet data'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/wallet - Recharge diamonds
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { userId, amount, type = 'recharge', reference } = body;

    if (!userId || !amount) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing userId or amount'),
        { status: 400 }
      );
    }

    const wallet = await WalletService.addDiamonds(
      userId,
      amount,
      type,
      reference || 'manual_recharge'
    );

    return NextResponse.json(
      successResponse(wallet, 'Diamonds added'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('ADD_FAILED', 'Failed to add diamonds'),
      { status: 500 }
    );
  }
}
