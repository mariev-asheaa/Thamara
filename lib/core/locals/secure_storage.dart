import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../constants/app_cached.dart';

@lazySingleton
class CachedSecure {
  final FlutterSecureStorage storage;

  CachedSecure({required this.storage});

  Future<void> saveToken(String value) async {
    return await storage.write(key: AppCached.token, value: value);
  }

  Future<String?> getToken() async {
    return await storage.read(key: AppCached.token);
  }

  Future<bool> containToken() async {
    return await storage.containsKey(key: AppCached.token);
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: AppCached.token);
  }
}
