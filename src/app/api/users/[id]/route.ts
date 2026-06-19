import { NextRequest, NextResponse } from 'next/server';
import { UserService } from '@/services';
import { successResponse, errorResponse } from '@/utils/api';

/**
 * GET /api/users/[id] - Get user profile
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const user = await UserService.getUserById(params.id);
    
    if (!user) {
      return NextResponse.json(
        errorResponse('NOT_FOUND', 'User not found'),
        { status: 404 }
      );
    }

    const profile = await UserService.getUserProfile(params.id);
    const stats = await UserService.getUserStats(params.id);

    return NextResponse.json(
      successResponse({ user, profile, stats }, 'User retrieved')
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch user'),
      { status: 500 }
    );
  }
}
