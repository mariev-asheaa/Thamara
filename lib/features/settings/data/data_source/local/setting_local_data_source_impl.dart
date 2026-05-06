import 'package:injectable/injectable.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/locals/secure_storage.dart';
import '../../../../../core/locals/shared_preferences.dart';
import 'setting_local_data_source.dart';

@Injectable(as: SettingLocalDataSource)
class SettingLocalDataSourceImpl extends SettingLocalDataSource {
  final SharedPrefServices appPref;
  final CachedSecure secure;

  SettingLocalDataSourceImpl({required this.appPref, required this.secure});

  @override
  Future<void> clearDataUser() async {
    try {
      await Future.wait([appPref.clearData(), secure.deleteToken()]);
    } catch (_) {
      throw CacheSaveException();
    }
  }
}
