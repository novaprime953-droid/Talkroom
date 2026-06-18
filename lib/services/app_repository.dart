import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../data/mock_data.dart';
import '../models/chat_message.dart';
import '../models/gift.dart';
import '../models/room.dart';
import '../models/user.dart';

/// Loads live data from Vercel; falls back to mock when offline.
class AppRepository extends ChangeNotifier {
  AppRepository._();
  static final AppRepository instance = AppRepository._();

  final _api = ApiService();

  AppUser currentUser = MockData.currentUser;
  List<VoiceRoom> rooms = List.from(MockData.rooms);
  List<GiftItem> gifts = List.from(MockData.gifts);
  List<AppUser> micUsers = List.from(MockData.micUsers);
  List<ChatMessage> roomMessages = List.from(MockData.roomMessages);
  List<({String name, String message, String time, int unread})> conversations =
      List.from(MockData.conversations);
  List<String> exploreCategories = List.from(MockData.exploreCategories);
  List<Map<String, dynamic>> pkBattles = [];
  List<Map<String, dynamic>> vipTiers = [];
  List<Map<String, dynamic>> webPanels = [];
  bool loaded = false;
  bool loading = false;

  Future<void> load() async {
    if (!ApiConfig.useRemoteApi || loading) return;
    loading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _api.fetchConfig(),
        _api.fetchRooms(),
        _api.fetchGifts(),
        _api.fetchUsersBundle(),
        _api.fetchRoomMessages(),
        _api.fetchConversations(),
        _api.fetchPkBattles(),
      ]);

      final config = results[0] as Map<String, dynamic>?;
      final remoteRooms = results[1] as List<VoiceRoom>;
      final remoteGifts = results[2] as List<GiftItem>;
      final usersBundle = results[3] as ({AppUser? current, List<AppUser> mic})?;
      final remoteMessages = results[4] as List<ChatMessage>;
      final remoteConversations = results[5] as List<({String name, String message, String time, int unread})>;
      final remotePk = results[6] as List<Map<String, dynamic>>;

      if (config != null) {
        exploreCategories = (config['exploreCategories'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            exploreCategories;
        vipTiers = (config['vipTiers'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>() ??
            vipTiers;
        webPanels = (config['webPanels'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>() ??
            webPanels;
      }
      if (remoteRooms.isNotEmpty) rooms = remoteRooms;
      if (remoteGifts.isNotEmpty) gifts = remoteGifts;
      if (usersBundle?.current != null) currentUser = usersBundle!.current!;
      if (usersBundle != null && usersBundle.mic.isNotEmpty) micUsers = usersBundle.mic;
      if (remoteMessages.isNotEmpty) roomMessages = remoteMessages;
      if (remoteConversations.isNotEmpty) conversations = remoteConversations;
      if (remotePk.isNotEmpty) pkBattles = remotePk;
      loaded = true;
    } catch (e) {
      debugPrint('AppRepository load error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  String svipEntryAsset(int tier) => MockData.svipEntryAsset(tier);
}

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<Map<String, dynamic>?> fetchConfig() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/config')));
    if (res.statusCode != 200) return null;
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<List<VoiceRoom>> fetchRooms() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/rooms')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['rooms'] as List? ?? []).map((e) => _roomFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<GiftItem>> fetchGifts() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/gifts')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['gifts'] as List? ?? []).map((e) => _giftFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<({AppUser? current, List<AppUser> mic})?> fetchUsersBundle() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/users')));
    if (res.statusCode != 200) return null;
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (
      current: data['currentUser'] != null ? _userFromJson(data['currentUser'] as Map<String, dynamic>) : null,
      mic: (data['micUsers'] as List? ?? []).map((e) => _userFromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<ChatMessage>> fetchRoomMessages() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/messages')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['messages'] as List? ?? []).map((e) => _messageFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<({String name, String message, String time, int unread})>> fetchConversations() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/messages?type=conversations')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['conversations'] as List? ?? []).map((e) {
      final m = e as Map<String, dynamic>;
      return (name: m['name'] as String, message: m['message'] as String, time: m['time'] as String, unread: m['unread'] as int? ?? 0);
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchPkBattles() async {
    final res = await _client.get(Uri.parse(ApiConfig.endpoint('/api/pk')));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['battles'] as List? ?? []).cast<Map<String, dynamic>>();
  }

  VoiceRoom _roomFromJson(Map<String, dynamic> j) {
    final g = (j['coverGradient'] as List? ?? [0x0e7490, 0x164e63]).cast<int>();
    return VoiceRoom(
      id: j['id'] as String,
      title: j['title'] as String,
      hostName: j['hostName'] as String,
      hostAvatar: j['hostAvatar'] as String,
      listeners: j['listeners'] as int,
      category: j['category'] as String,
      tags: (j['tags'] as List).cast<String>(),
      isLive: j['isLive'] as bool? ?? true,
      coverGradient: [g[0], g.length > 1 ? g[1] : g[0]],
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
      category: switch (j['category'] as String) {
        'luxury' => GiftCategory.luxury,
        'lucky' => GiftCategory.lucky,
        'svip' => GiftCategory.svip,
        _ => GiftCategory.popular,
      },
      isLucky: j['isLucky'] as bool? ?? false,
      multiplier: j['multiplier'] as int?,
      svgaAsset: j['svgaAsset'] as String?,
      lottieAsset: j['lottieAsset'] as String?,
    );
  }

  AppUser _userFromJson(Map<String, dynamic> j) => AppUser(
        id: j['id'] as String? ?? 'u',
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

  ChatMessage _messageFromJson(Map<String, dynamic> j) => ChatMessage(
        id: j['id'] as String,
        userName: j['userName'] as String,
        content: j['content'] as String,
        type: switch (j['type'] as String) {
          'gift' => ChatMessageType.gift,
          'entry' => ChatMessageType.entry,
          'system' => ChatMessageType.system,
          _ => ChatMessageType.text,
        },
        timestamp: DateTime.tryParse(j['timestamp'] as String? ?? '') ?? DateTime.now(),
        vipTier: j['vipTier'] as int? ?? 0,
        giftEmoji: j['giftEmoji'] as String?,
      );
}
