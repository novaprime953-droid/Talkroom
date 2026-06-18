import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/chat_message.dart';
import '../models/gift.dart';
import '../models/room.dart';
import '../models/user.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>?> fetchConfig() async {
    if (!ApiConfig.useRemoteApi) return null;
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/config')));
    if (res.statusCode != 200) return null;
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<List<VoiceRoom>> fetchRooms() async {
    if (!ApiConfig.useRemoteApi) return [];
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/rooms')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = data['rooms'] as List<dynamic>? ?? [];
    return list.map((e) => _roomFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<GiftItem>> fetchGifts() async {
    if (!ApiConfig.useRemoteApi) return [];
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/gifts')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = data['gifts'] as List<dynamic>? ?? [];
    return list.map((e) => _giftFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<AppUser?> fetchCurrentUser() async {
    if (!ApiConfig.useRemoteApi) return null;
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/users')));
    if (res.statusCode != 200) return null;
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final user = data['currentUser'];
    if (user == null) return null;
    return _userFromJson(user as Map<String, dynamic>);
  }

  Future<List<ChatMessage>> fetchRoomMessages() async {
    if (!ApiConfig.useRemoteApi) return [];
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/messages')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = data['messages'] as List<dynamic>? ?? [];
    return list.map((e) => _messageFromJson(e as Map<String, dynamic>)).toList();
  }

  VoiceRoom _roomFromJson(Map<String, dynamic> j) {
    final gradient = (j['coverGradient'] as List<dynamic>? ?? [0x0e7490, 0x164e63])
        .map((e) => e as int)
        .toList();
    return VoiceRoom(
      id: j['id'] as String,
      title: j['title'] as String,
      hostName: j['hostName'] as String,
      hostAvatar: j['hostAvatar'] as String,
      listeners: j['listeners'] as int,
      category: j['category'] as String,
      tags: (j['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isLive: j['isLive'] as bool? ?? true,
      coverGradient: [gradient[0], gradient.length > 1 ? gradient[1] : gradient[0]],
      micCount: j['micCount'] as int? ?? 8,
      isPk: j['isPk'] as bool? ?? false,
    );
  }

  GiftItem _giftFromJson(Map<String, dynamic> j) {
    return GiftItem(
      id: j['id'] as String,
      name: j['name'] as String,
      emoji: j['emoji'] as String,
      price: j['price'] as int,
      category: _giftCategory(j['category'] as String),
      isLucky: j['isLucky'] as bool? ?? false,
      multiplier: j['multiplier'] as int?,
      svgaAsset: j['svgaAsset'] as String?,
      lottieAsset: j['lottieAsset'] as String?,
    );
  }

  GiftCategory _giftCategory(String value) {
    switch (value) {
      case 'luxury':
        return GiftCategory.luxury;
      case 'lucky':
        return GiftCategory.lucky;
      case 'svip':
        return GiftCategory.svip;
      default:
        return GiftCategory.popular;
    }
  }

  AppUser _userFromJson(Map<String, dynamic> j) {
    return AppUser(
      id: j['id'] as String? ?? 'unknown',
      name: j['name'] as String? ?? 'User',
      avatarUrl: j['avatarUrl'] as String? ?? '',
      vipTier: j['vipTier'] as int? ?? 0,
      coins: j['coins'] as int? ?? 0,
      level: j['level'] as int? ?? 1,
      isOnline: j['isOnline'] as bool? ?? true,
      bio: j['bio'] as String? ?? '',
      followers: j['followers'] as int? ?? 0,
      following: j['following'] as int? ?? 0,
    );
  }

  ChatMessage _messageFromJson(Map<String, dynamic> j) {
    return ChatMessage(
      id: j['id'] as String,
      userName: j['userName'] as String,
      content: j['content'] as String,
      type: _messageType(j['type'] as String),
      timestamp: DateTime.tryParse(j['timestamp'] as String? ?? '') ?? DateTime.now(),
      vipTier: j['vipTier'] as int? ?? 0,
      giftEmoji: j['giftEmoji'] as String?,
    );
  }

  ChatMessageType _messageType(String value) {
    switch (value) {
      case 'gift':
        return ChatMessageType.gift;
      case 'entry':
        return ChatMessageType.entry;
      case 'system':
        return ChatMessageType.system;
      default:
        return ChatMessageType.text;
    }
  }
}
