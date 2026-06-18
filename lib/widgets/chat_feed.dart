import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class ChatFeed extends StatelessWidget {
  const ChatFeed({super.key, required this.messages});

  final List<ChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[messages.length - 1 - index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _MessageBubble(message: msg),
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case ChatMessageType.system:
        return Center(
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            borderRadius: 12,
            child: Text(
              message.content,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ),
        );
      case ChatMessageType.entry:
        return _buildSpecialBanner(
          icon: Icons.auto_awesome_rounded,
          gradient: AppColors.svipGradient,
          text: '${message.userName} ${message.content}',
        );
      case ChatMessageType.gift:
        return _buildSpecialBanner(
          icon: Icons.card_giftcard_rounded,
          gradient: AppColors.vipGradient,
          text: '${message.userName} ${message.content} ${message.giftEmoji ?? ''}',
        );
      case ChatMessageType.text:
        return Align(
          alignment: Alignment.centerLeft,
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            borderRadius: 16,
            child: RichText(
              text: TextSpan(
                children: [
                  if (message.vipTier > 0)
                    TextSpan(
                      text: message.vipTier >= 5 ? '[SVIP${message.vipTier}] ' : '[VIP${message.vipTier}] ',
                      style: TextStyle(
                        color: AppColors.vipColorForTier(message.vipTier),
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  TextSpan(
                    text: '${message.userName}: ',
                    style: const TextStyle(
                      color: AppColors.teal400,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: message.content,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  Widget _buildSpecialBanner({
    required IconData icon,
    required List<Color> gradient,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient.map((c) => c.withValues(alpha: 0.3)).toList()),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gradient.first.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: gradient.first, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
