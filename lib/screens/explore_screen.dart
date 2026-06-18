import 'package:flutter/material.dart';
import '../services/app_repository.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/room_card.dart';
import 'pk_battle_screen.dart';
import 'voice_room_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final repo = AppRepository.instance;
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Explore',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: repo.exploreCategories.length,
                  itemBuilder: (context, index) {
                    final selected = _selectedCategory == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(repo.exploreCategories[index]),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedCategory = index),
                        selectedColor: AppColors.teal500,
                        backgroundColor: AppColors.navy700,
                        labelStyle: TextStyle(
                          color: selected ? AppColors.navy900 : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PkBattleScreen()),
                  ),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: 24,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.purple500.withValues(alpha: 0.4),
                            AppColors.pink500.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: AppColors.svipGradient),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PK Battle Arena',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Challenge hosts · Win rewards',
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final room = repo.rooms[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: RoomCard(
                        room: room,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => VoiceRoomScreen(room: room)),
                        ),
                      ),
                    );
                  },
                  childCount: repo.rooms.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
