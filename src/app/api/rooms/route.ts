import { NextRequest, NextResponse } from 'next/server';
import { RoomService, UserService, WalletService, initializeDefaultData } from '@/services';
import { successResponse, errorResponse, validateRequestBody } from '@/utils/api';

// Initialize data on first run
initializeDefaultData();

/**
 * GET /api/rooms - Get all active rooms
 */
export async function GET() {
  try {
    const rooms = await RoomService.getAllRooms();
    
    return NextResponse.json(
      successResponse(
        rooms.map(r => ({
          id: r.id,
          name: r.name,
          category: r.category,
          members: r.currentMemberCount,
          maxMembers: r.maxMembers,
          owner: r.ownerId,
          thumbnail: r.thumbnail,
          isPK: r.isPK,
          createdAt: r.createdAt,
        })),
        `Found ${rooms.length} active rooms`
      )
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('FETCH_FAILED', 'Failed to fetch rooms'),
      { status: 500 }
    );
  }
}

/**
 * POST /api/rooms - Create new room
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const validation = validateRequestBody(body, ['name', 'ownerId', 'category']);
    if (!validation) {
      return NextResponse.json(
        errorResponse('INVALID_REQUEST', 'Missing required fields'),
        { status: 400 }
      );
    }

    const room = await RoomService.createRoom({
      name: body.name,
      ownerId: body.ownerId,
      description: body.description,
      category: body.category,
      isPrivate: body.isPrivate || false,
      maxMembers: body.maxMembers || 8,
    });

    return NextResponse.json(
      successResponse(room, 'Room created successfully'),
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      errorResponse('CREATE_FAILED', 'Failed to create room'),
      { status: 500 }
    );
  }
}
