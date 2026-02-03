import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  //InternetConnection get internetConnection => InternetConnection();
  @lazySingleton
  Dio get dioClient => Dio();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
