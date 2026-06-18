import 'package:flutter/material.dart';

import '../config/api_config.dart';
import '../data/mock_data.dart';
import '../models/room.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/room_card.dart';
import 'voice_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  List<VoiceRoom> _rooms = MockData.rooms;
  bool _loading = ApiConfig.useRemoteApi;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    if (!ApiConfig.useRemoteApi) return;
    final remote = await _api.fetchRooms();
    if (remote.isNotEmpty && mounted) {
      setState(() {
        _rooms = remote;
        _loading = false;
      });
    } else if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final featured = _rooms.first;
    final others = _rooms.length > 1 ? _rooms.skip(1).toList() : <VoiceRoom>[];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: AppColors.accentGradient,
                          ).createShader(bounds),
                          child: const Text(
                            'Talk Room',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          ApiConfig.useRemoteApi
                              ? 'Connected to cloud'
                              : 'Live voice rooms near you',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (_loading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    GlassContainer(
                      padding: const EdgeInsets.all(10),
                      borderRadius: 14,
                      child: const Icon(Icons.notifications_none_rounded, size: 22),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  borderRadius: 16,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search rooms, hosts, tags...',
                      hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                      border: InputBorder.none,
                      icon: Icon(Icons.search_rounded, color: AppColors.teal400),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  children: [
                    const Text(
                      'Featured Live',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all', style: TextStyle(color: AppColors.teal400)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoomCard(
                  room: featured,
                  isFeatured: true,
                  onTap: () => _openRoom(context, featured),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: const Text(
                  'Discover Rooms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => RoomCard(
                    room: others[index],
                    onTap: () => _openRoom(context, others[index]),
                  ),
                  childCount: others.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openRoom(BuildContext context, VoiceRoom room) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VoiceRoomScreen(room: room),
      ),
    );
  }
}
