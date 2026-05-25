import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/thamara_app.dart';
import 'core/dependency_injection/di.dart';
import 'firebase_options.dart';

/// Easy Localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations
///code generator runner
///dart run build_runner build
/// Di (InjectableInit)
/// dart run build_runner build --delete-conflicting-outputs
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    configureDependencies(),
    ScreenUtil.ensureScreenSize(),
    EasyLocalization.ensureInitialized(),
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled:false,
      builder: (context) => EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        startLocale: const Locale('en'),
        child: const Thamara(),
      ),
    ),
  );
}


