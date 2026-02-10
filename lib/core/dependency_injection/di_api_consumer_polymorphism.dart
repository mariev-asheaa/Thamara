import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../api/network_info.dart';
import '../locals/secure_storage.dart';
import '../locals/shared_preferences.dart';
import 'di.dart';

@lazySingleton
class ApiConsumerPolymorphism {
  @lazySingleton
  @Named("aiConsumer")
  ApiConsumer aiConsumer(@factoryParam @Named("aiDio") Dio dio) {
    return DioApiConsumer(
      dioClient: dio,
      networkInfo: getIt<NetworkInfo>(),
      cachedSecure: getIt<CachedSecure>(),
      appPref: getIt<SharedPrefServices>(),
    );
  }
}
