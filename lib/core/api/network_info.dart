import 'dart:io';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NetworkInfo {
  InternetConnection? _internetConnection;

  InternetConnection get _connection {
    _internetConnection ??= InternetConnection.createInstance(
      checkInterval: const Duration(seconds: 2),
      customCheckOptions: [
        InternetCheckOption(
          uri: Uri.parse('https://one.one.one.one'),
          timeout: const Duration(seconds: 1),
        ),
      ],
    );
    return _internetConnection!;
  }

  Future<bool> get isConnected async => await _checkInternetFast();

  Future<bool> _checkInternetFast() async {
    try {
      final hasConnection = await _connection.hasInternetAccess.timeout(
        const Duration(seconds: 2),
        onTimeout: () => false,
      );

      if (hasConnection) return true;

      try {
        final result = await InternetAddress.lookup('google.com').timeout(
          const Duration(milliseconds: 800),
          onTimeout: () => [],
        );
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _internetConnection = null;
  }
}
