import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConstants {
  static String get gitBaseUrl => dotenv.env['GITHUB_BASE_URL'] ?? '';
  static String get token => dotenv.env['GITHUB_TOKEN'] ?? '';
}
