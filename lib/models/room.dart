class VoiceRoom {
  const VoiceRoom({
    required this.id,
    required this.title,
    required this.hostName,
    required this.hostAvatar,
    required this.listeners,
    required this.category,
    required this.tags,
    required this.isLive,
    required this.coverGradient,
    this.micCount = 8,
    this.isPk = false,
  });

  final String id;
  final String title;
  final String hostName;
  final String hostAvatar;
  final int listeners;
  final String category;
  final List<String> tags;
  final bool isLive;
  final List<int> coverGradient;
  final int micCount;
  final bool isPk;
}
