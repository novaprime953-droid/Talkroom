import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/api_config.dart';

/// Opens in-app web panels hosted on the Vercel backend.
class WebPanelLauncher {
  static Future<void> open(BuildContext context, String panelPath) async {
    if (!ApiConfig.useRemoteApi) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Set API_BASE_URL to your Vercel link to open web panels'),
        ),
      );
      return;
    }

    final url = Uri.parse(ApiConfig.endpoint(panelPath));
  if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    }
  }
}
