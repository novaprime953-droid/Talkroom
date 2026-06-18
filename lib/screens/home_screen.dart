import 'package:flutter/material.dart';
import '../models/room.dart';
import '../services/app_repository.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/room_card.dart';
import 'voice_room_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = AppRepository.instance;
    final rooms = repo.rooms;
    if (rooms.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final featured = rooms.first;
    final others = rooms.length > 1 ? rooms.skip(1).toList() : <VoiceRoom>[];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: repo.load,
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
                            shaderCallback: (b) => LinearGradient(colors: AppColors.accentGradient).createShader(b),
                            child: const Text('Talk Room', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
                          ),
                          Text(
                            repo.loaded ? 'Live · talkroom-qvwu.vercel.app' : 'Syncing...',
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (repo.loading) const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('Featured Live', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RoomCard(room: featured, isFeatured: true, onTap: () => _openRoom(context, featured)),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 12),
                  child: Text('Discover Rooms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
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
                    (context, i) => RoomCard(room: others[i], onTap: () => _openRoom(context, others[i])),
                    childCount: others.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openRoom(BuildContext context, VoiceRoom room) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => VoiceRoomScreen(room: room)));
  }
}
