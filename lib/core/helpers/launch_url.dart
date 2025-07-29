import 'package:url_launcher/url_launcher.dart';

import 'log.dart';

void launchAppUrl(String url) async {
  final uri = Uri.parse(url);
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched) {
    LogManager.instance.e('Could not launch $url');
  }
}
