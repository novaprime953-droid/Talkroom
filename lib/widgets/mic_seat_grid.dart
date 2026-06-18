import 'package:flutter/material.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import 'avatar_frame.dart';

class MicSeatGrid extends StatelessWidget {
  const MicSeatGrid({
    super.key,
    required this.host,
    required this.seats,
    required this.onSeatTap,
  });

  final AppUser host;
  final List<AppUser?> seats;
  final ValueChanged<int> onSeatTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHostSeat(),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: seats.length,
          itemBuilder: (context, index) => _buildSeat(index, seats[index]),
        ),
      ],
    );
  }

  Widget _buildHostSeat() {
    return Column(
      children: [
        AvatarFrame(user: host, size: 80, isSpeaking: true),
        const SizedBox(height: 8),
        Text(
          host.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.svipGradient),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'HOST',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSeat(int index, AppUser? user) {
    if (user == null) {
      return GestureDetector(
        onTap: () => onSeatTap(index),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.navy600.withValues(alpha: 0.6),
                border: Border.all(color: AppColors.glassBorder, width: 1.5),
              ),
              child: const Icon(Icons.add_rounded, color: AppColors.textMuted, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              'Seat ${index + 1}',
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => onSeatTap(index),
      child: Column(
        children: [
          AvatarFrame(user: user, size: 56, isSpeaking: index == 1),
          const SizedBox(height: 6),
          Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
