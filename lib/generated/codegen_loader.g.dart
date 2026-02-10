// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "enterFullOTP": "يرجى إدخال رمز التحقق الكامل",
  "phoneNumber": "رقم الهاتف",
  "unKnownError": "خطأ غير معروف، يرجى المحاولة مرة أخرى",
  "cacheError": "خطأ في التخزين المؤقت، أعد المحاولة",
  "noInternetError": "لا يوجد اتصال بالإنترنت",
  "serverError": "حدث خطأ، يرجى المحاولة لاحقًا",
  "notFoundError": "لم يتم العثور على طلبك، حاول لاحقًا",
  "timeOutError": "انتهت مهلة الاتصال، يرجى المحاولة مجددًا",
  "youShouldInternet": "يرجى التحقق من اتصالك بالإنترنت ثم أعد المحاولة"
};
static const Map<String,dynamic> _en = {
  "enterFullOTP": "Please enter the full OTP code",
  "phoneNumber": "Phone Number",
  "unKnownError": "Unknown error, please try again",
  "cacheError": "Cache error, please try again",
  "noInternetError": "No Internet connection",
  "serverError": "There was an error, please try again",
  "notFoundError": "Your request was not found, please try later",
  "timeOutError": "Timeout error, please try again",
  "youShouldInternet": "Please check your network connection and try again"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
