import 'dart:html' as html;

/// A utility class for launching URLs in the web browser
class UrlLauncher {
  /// Launches a URL in a new tab
  static void launchUrl(String url) {
    html.window.open(url, '_blank');
  }

  /// Launches an email client with the given email address
  static void launchEmail(String email) {
    html.window.open('mailto:$email', '_blank');
  }

  /// Launches a phone dialer with the given phone number
  static void launchPhone(String phone) {
    html.window.open('tel:$phone', '_blank');
  }
}
