import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:r_upgrade/r_upgrade.dart';

class UpdateService {
  // Replace 'YOUR_GITHUB_USERNAME' and 'YOUR_REPO_NAME' with your actual details.
  // The workflow publishes version.json to the 'gh-pages' branch.
  static const String _versionUrl =
      'https://fattym.github.io/Elimupepe/version.json';

  static Future<void> checkAndUpdate(BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      final String currentVersion = info.version;

      final response = await http.get(Uri.parse(_versionUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String latestVersion = data['version'];
        final String apkUrl = data['url'];
        final String? changelog = data['changelog'];

        if (_shouldUpdate(currentVersion, latestVersion)) {
          if (context.mounted) {
            _showUpdateDialog(context, latestVersion, apkUrl, changelog);
          }
        }
      }
    } catch (e) {
      debugPrint('Update check failed: $e');
    }
  }

  static bool _shouldUpdate(String current, String latest) {
    List<int> currParts = current.split('.').map(int.parse).toList();
    List<int> latestParts = latest.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (i >= currParts.length) return true;
      if (latestParts[i] > currParts[i]) return true;
      if (latestParts[i] < currParts[i]) return false;
    }
    return false;
  }

  static void _showUpdateDialog(
    BuildContext context,
    String version,
    String url,
    String? changelog,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('New Update Available ($version)'),
        content: Text(changelog ?? 'A new version of ElimuPepe is available.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _downloadAndInstall(url);
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  static Future<void> _downloadAndInstall(String url) async {
    await RUpgrade.upgrade(
      url,
      fileName: 'elimupepe_update.apk',
      // isAutoRequestInstall: true,
      notificationStyle: NotificationStyle.speechAndPlanTime,
    );
  }
}
