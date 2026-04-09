import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/app_cached.dart';
import '../../../../../../core/locals/secure_storage.dart';
import '../../../../../../core/locals/shared_preferences.dart';
import 'register_local_data_source.dart';

@Injectable(as: RegisterLocalDataSource)
class RegisterLocalDataSourceImpl extends RegisterLocalDataSource {
  final SharedPrefServices appPref;
  final CachedSecure secure;

  RegisterLocalDataSourceImpl({
    required this.appPref,
    required this.secure,
  });

  @override
  Future<void> saveToken({required String token}) async {
    try {
      await secure.saveToken(token);
      await appPref.saveData(AppCached.hasToken, true);
    } catch (error) {
      throw Exception('Failed to save token: $error');
    }
  }
}
