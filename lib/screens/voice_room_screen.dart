import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/app_repository.dart';
import '../models/chat_message.dart';
import '../models/gift.dart';
import '../models/room.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import '../widgets/chat_feed.dart';
import '../widgets/gift_panel.dart';
import '../widgets/glass_container.dart';
import '../widgets/lucky_gift_overlay.dart';
import '../widgets/mic_seat_grid.dart';
import '../widgets/vip_entry_banner.dart';
import 'pk_battle_screen.dart';

class VoiceRoomScreen extends StatefulWidget {
  const VoiceRoomScreen({super.key, required this.room});

  final VoiceRoom room;

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  late List<ChatMessage> _messages;
  bool _showGiftPanel = false;
  bool _showEntryBanner = true;
  bool _showGiftOverlay = false;
  bool _showLuckyOverlay = false;
  GiftItem? _activeGift;
  int _luckyMultiplier = 10;

  @override
  void initState() {
    super.initState();
    _messages = List.from(AppRepository.instance.roomMessages);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showEntryBanner = false);
    });
  }

  List<AppUser?> get _seats {
    final users = AppRepository.instance.micUsers.skip(1).toList();
    return List<AppUser?>.generate(8, (i) => i < users.length ? users[i] : null);
  }

  void _sendGift(GiftItem gift) {
    setState(() {
      _showGiftPanel = false;
      _activeGift = gift;
      _showGiftOverlay = true;
      _messages.add(
        ChatMessage(
          id: 'c${_messages.length}',
          userName: AppRepository.instance.currentUser.name,
          content: 'sent ${gift.name} to ${AppRepository.instance.micUsers.first.name}',
          type: ChatMessageType.gift,
          timestamp: DateTime.now(),
          vipTier: AppRepository.instance.currentUser.vipTier,
          giftEmoji: gift.emoji,
        ),
      );
    });

    if (gift.isLucky) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showGiftOverlay = false;
            _showLuckyOverlay = true;
            _luckyMultiplier = gift.multiplier ?? 10;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(widget.room.coverGradient[0]),
                  AppColors.navy900,
                  AppColors.navy800,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          MicSeatGrid(
                            host: AppRepository.instance.micUsers.first,
                            seats: _seats,
                            onSeatTap: (_) {},
                          ),
                          if (widget.room.isPk) ...[
                            const SizedBox(height: 16),
                            _buildPkBanner(),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 140,
                    child: ChatFeed(messages: _messages),
                  ),
                  _buildBottomBar(),
                ],
              ),
            ),
          ),
          if (_showEntryBanner)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 0,
              right: 0,
              child: VipEntryBanner(
                user: AppRepository.instance.currentUser,
                svgaAsset: AppRepository.instance.svipEntryAsset(AppRepository.instance.currentUser.vipTier),
                onComplete: () => setState(() => _showEntryBanner = false),
              ),
            ),
          if (_showGiftPanel)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GiftPanel(
                gifts: AppRepository.instance.gifts,
                coins: AppRepository.instance.currentUser.coins,
                onSend: _sendGift,
                onClose: () => setState(() => _showGiftPanel = false),
              ),
            ),
          if (_showGiftOverlay && _activeGift != null)
            GiftSendOverlay(
              gift: _activeGift!,
              senderName: AppRepository.instance.currentUser.name,
              onComplete: () {
                if (!_activeGift!.isLucky) {
                  setState(() => _showGiftOverlay = false);
                }
              },
            ),
          if (_showLuckyOverlay)
            LuckyGiftOverlay(
              multiplier: _luckyMultiplier,
              onComplete: () => setState(() => _showLuckyOverlay = false),
            ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Expanded(
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              borderRadius: 16,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.room.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                        ),
                        Text(
                          '${widget.room.listeners} listening',
                          style: const TextStyle(color: AppColors.teal400, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Lottie.asset('assets/lottie/mic/data.json'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GlassContainer(
            padding: const EdgeInsets.all(8),
            borderRadius: 12,
            child: const Icon(Icons.share_outlined, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPkBanner() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PkBattleScreen()),
      ),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.svipGradient),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.flash_on_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PK Battle Live', style: TextStyle(fontWeight: FontWeight.w800)),
                  Text(
                    'Tap to join the arena',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.navy800.withValues(alpha: 0.9),
        border: const Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              borderRadius: 24,
              child: const Text(
                'Say something...',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _actionButton(Icons.mic_rounded, AppColors.teal500),
          const SizedBox(width: 8),
          _actionButton(
            Icons.card_giftcard_rounded,
            AppColors.gold400,
            onTap: () => setState(() => _showGiftPanel = true),
          ),
          const SizedBox(width: 8),
          _actionButton(Icons.more_horiz_rounded, AppColors.navy600),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withValues(alpha: color == AppColors.navy600 ? 1 : 0.2),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Icon(icon, color: color == AppColors.navy600 ? AppColors.textPrimary : color),
      ),
    );
  }
}
