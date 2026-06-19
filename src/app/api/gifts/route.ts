import { NextRequest, NextResponse } from 'next/server';
import { WalletService, UserService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/gifts - Get all gifts
 */
export function GET() {
  try {
    const gifts = WalletService.getAllGifts();
    
    return NextResponse.json(
      successResponse(gifts, `Retrieved ${gifts.length} gifts`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch gifts'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/gifts - Send gift
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { senderId, giftId, quantity, recipientId } = body;

    if (!senderId || !giftId || !quantity || !recipientId) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing required fields'),
        { status: 400 }
      );
    }

    const gift = WalletService.getGift(giftId);
    if (!gift) {
      return NextResponse.json(
        errorResponse('NOT_FOUND', 'Gift not found'),
        { status: 404 }
      );
    }

    const totalCost = gift.diamondCost * quantity;

    // Check balance
    const isValid = await WalletService.validatePurchase(senderId, totalCost);
    if (!isValid) {
      return NextResponse.json(
        errorResponse('INSUFFICIENT_BALANCE', 'Not enough diamonds'),
        { status: 400 }
      );
    }

    // Spend diamonds from sender
    await WalletService.spendDiamonds(senderId, totalCost, 'gift', `Gift: ${gift.name}`);

    // Record gift received
    await UserService.recordGiftSent(senderId, totalCost);
    await UserService.recordGiftReceived(recipientId);

    // Create transaction record
    const transaction = {
      id: `gift_${Date.now()}`,
      senderId,
      recipientId,
      giftId,
      giftName: gift.name,
      quantity,
      totalDiamonds: totalCost,
      createdAt: new Date(),
    };

    return NextResponse.json(
      successResponse(transaction, 'Gift sent successfully'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('SEND_FAILED', 'Failed to send gift'),
      { status: 500 }
    );
  }
}
