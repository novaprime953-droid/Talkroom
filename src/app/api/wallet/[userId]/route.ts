import { NextRequest, NextResponse } from 'next/server';
import { WalletService, UserService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/wallet/[userId] - Get wallet balance
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { userId: string } }
) {
  try {
    let wallet = await WalletService.getWallet(params.userId);
    
    if (!wallet) {
      // Initialize if doesn't exist
      wallet = await WalletService.initializeWallet(params.userId, 100); // Start with 100 diamonds
    }

    const stats = await WalletService.getWalletStats(params.userId);
    
    return NextResponse.json(
      successResponse({ wallet, stats }, 'Wallet retrieved')
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch wallet'),
      { status: 500 }
    );
  }
}
