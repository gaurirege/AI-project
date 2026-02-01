import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class AppConfig {
  static String get baseUrl {
    // Flutter Web
    if (kIsWeb) {
      return "http://192.168.0.205:8000";
    }
    
    // Desktop and Mobile
    try {
      if (Platform.isWindows) {
        return "http://localhost:8000";
      } else if (Platform.isAndroid || Platform.isIOS) {
        return "http://192.168.0.205:8000";
      }
    } catch (e) {
      return "http://192.168.0.205:8000";
    }
    
    return "http://192.168.0.205:8000";
  }
}