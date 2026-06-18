/// Production backend on Vercel.
class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://talkroom-qvwu.vercel.app',
  );

  static bool get useRemoteApi => baseUrl.isNotEmpty;

  static String endpoint(String path) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return '$baseUrl$normalized';
  }

  static String panelUrl(String path) => endpoint(path);
}
