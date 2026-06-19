# Flutter Integration with TalkRoom Backend

## Step 1: Get Your Vercel URL

After deploying to Vercel, you'll get a URL like:
```
https://talkroom-xxxxx.vercel.app
```

## Step 2: Update Flutter Environment Variables

In `lib/main.dart`, replace the hardcoded URLs with your Vercel backend:

```dart
const String API_BASE_URL = 'https://talkroom-xxxxx.vercel.app';
const String WEBSOCKET_URL = 'wss://talkroom-xxxxx.vercel.app';
```

Or use `.env` file with `flutter_dotenv` package:

```env
# .env file
API_BASE_URL=https://talkroom-xxxxx.vercel.app
WEBSOCKET_URL=wss://talkroom-xxxxx.vercel.app
```

## Step 3: Update API Service

In `lib/services/api_service.dart`:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://talkroom-xxxxx.vercel.app/api';

  // User Registration
  static Future<Map> registerUser({
    required String email,
    required String username,
    required String password,
    required String avatar,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'username': username,
        'password': password,
        'avatar': avatar,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Get Rooms
  static Future<List<dynamic>> getRooms() async {
    final response = await http.get(
      Uri.parse('$baseUrl/rooms'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  // Create Room
  static Future<Map> createRoom({
    required String name,
    required String ownerId,
    required String category,
    String? description,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rooms'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'ownerId': ownerId,
        'category': category,
        'description': description,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to create room');
    }
  }

  // Join Room
  static Future<Map> joinRoom({
    required String roomId,
    required String userId,
    required String username,
    required String avatar,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rooms/$roomId/join'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'username': username,
        'avatar': avatar,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to join room');
    }
  }

  // Send Message
  static Future<Map> sendMessage({
    required String roomId,
    required String userId,
    required String username,
    required String content,
    required String avatar,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'roomId': roomId,
        'userId': userId,
        'username': username,
        'content': content,
        'avatar': avatar,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to send message');
    }
  }

  // Get Gifts
  static Future<List<dynamic>> getGifts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/gifts'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load gifts');
    }
  }

  // Send Gift
  static Future<Map> sendGift({
    required String senderId,
    required String recipientId,
    required String giftId,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gifts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'senderId': senderId,
        'recipientId': recipientId,
        'giftId': giftId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to send gift');
    }
  }

  // Initiate PK Battle
  static Future<Map> initiatePK({
    required String roomId,
    required String initiatorId,
    required String initiatorUsername,
    required String challengerId,
    required String challengerUsername,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pk'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'roomId': roomId,
        'initiatorId': initiatorId,
        'initiatorUsername': initiatorUsername,
        'challengerId': challengerId,
        'challengerUsername': challengerUsername,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to initiate PK');
    }
  }

  // Get User Wallet
  static Future<Map> getWallet(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/wallet/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load wallet');
    }
  }
}
```

## Step 4: Update Models to Match Backend

In `lib/models/`, update models to match API response format:

```dart
class Room {
  final String id;
  final String name;
  final String category;
  final int members;
  final int maxMembers;
  final String owner;
  final String? thumbnail;
  final bool isPK;
  final DateTime createdAt;

  Room({
    required this.id,
    required this.name,
    required this.category,
    required this.members,
    required this.maxMembers,
    required this.owner,
    this.thumbnail,
    this.isPK = false,
    required this.createdAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      members: json['members'] ?? 0,
      maxMembers: json['maxMembers'] ?? 8,
      owner: json['owner'],
      thumbnail: json['thumbnail'],
      isPK: json['isPK'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Gift {
  final String id;
  final String name;
  final int diamondCost;
  final String icon;
  final String category;

  Gift({
    required this.id,
    required this.name,
    required this.diamondCost,
    required this.icon,
    required this.category,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'],
      name: json['name'],
      diamondCost: json['diamondCost'],
      icon: json['icon'] ?? '',
      category: json['category'] ?? 'normal',
    );
  }
}
```

## Step 5: Replace Mock Data with API Calls

In screens, replace mock data providers:

```dart
// Before (Mock)
List<Room> rooms = mockRooms;

// After (API)
Future<List<Room>> getRooms() async {
  try {
    final data = await ApiService.getRooms();
    return data.map((r) => Room.fromJson(r)).toList();
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
```

## Step 6: Build and Run

```bash
cd d:\APKs\TalkRoom

# Web
flutter run -d chrome

# Android (after device authorization)
flutter run -d <device_id>

# iOS
flutter run -d <device_id>

# Release build for Android
flutter build apk --release

# Release build for iOS
flutter build ios --release
```

## Testing Endpoints

### User Registration
```bash
curl -X POST https://talkroom-xxxxx.vercel.app/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "username": "testuser",
    "password": "password123",
    "avatar": "https://..."
  }'
```

### Get Rooms
```bash
curl https://talkroom-xxxxx.vercel.app/api/rooms
```

### Create Room
```bash
curl -X POST https://talkroom-xxxxx.vercel.app/api/rooms \
  -H "Content-Type: application/json" \
  -d '{
    "name": "My Room",
    "ownerId": "user_id",
    "category": "music"
  }'
```

## Common Issues

### CORS Errors
Add CORS headers in `vercel.json`:
```json
{
  "headers": [
    {
      "key": "Access-Control-Allow-Credentials",
      "value": "true"
    },
    {
      "key": "Access-Control-Allow-Origin",
      "value": "*"
    }
  ]
}
```

### SSL Certificate Issues
- Use HTTPS only (`https://talkroom-xxxxx.vercel.app`)
- Vercel provides free SSL certificates
- No additional configuration needed

### Timeout Issues
- Increase request timeout in Flutter HTTP client
- Check Vercel logs for backend errors
- Verify database connection

---

**Your Backend API URL**: `https://talkroom-xxxxx.vercel.app/api`
