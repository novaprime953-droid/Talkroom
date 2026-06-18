/// API base URL for Talk Room backend (Vercel deployment).
///
/// Set when building/running:
/// `flutter run --dart-define=API_BASE_URL=https://your-vercel-url.vercel.app`
class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static bool get useRemoteApi => baseUrl.isNotEmpty;

  static String endpoint(String path) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return '$baseUrl$normalized';
  }
}
