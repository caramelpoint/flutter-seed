import 'package:flutter/services.dart' show rootBundle;

class FixtureReader {
  Future<String> fixture(String name) => rootBundle.loadString('assets/json/$name');
}
