import { NextRequest, NextResponse } from 'next/server';
import { UserService, WalletService } from '@/services';
import { successResponse, errorResponse, validateRequestBody } from '@/utils/api';

/**
 * GET /api/users - Search or list users
 */
export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const query = searchParams.get('q');
    const limit = parseInt(searchParams.get('limit') || '20');

    let users: any[];

    if (query) {
      users = await UserService.searchUsers(query, limit);
    } else {
      users = await UserService.getTopUsersByLevel(limit);
    }

    return NextResponse.json(
      successResponse(users, `Found ${users.length} users`)
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('SEARCH_FAILED', 'Failed to search users'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/users - Create/Register new user
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const validation = validateRequestBody(body, ['email', 'username', 'password']);
    if (!validation) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing required fields'),
        { status: 400 }
      );
    }

    // Check if user already exists
    const existing = await UserService.getUserByEmail(body.email);
    if (existing) {
      return NextResponse.json(
        errorResponse('USER_EXISTS', 'User with this email already exists'),
        { status: 409 }
      );
    }

    const user = await UserService.createUser({
      email: body.email,
      phone: body.phone,
      username: body.username,
      password: body.password,
      avatar: body.avatar,
      country: body.country,
    });

    // Initialize wallet
    await WalletService.initializeWallet(user.id, 100); // 100 starting diamonds

    return NextResponse.json(
      successResponse({ user }, 'User created successfully'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('CREATE_FAILED', 'Failed to create user'),
      { status: 500 }
    );
  }
}
