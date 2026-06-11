import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:thamara/app/thamara_app.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../locals/secure_storage.dart';
import '../locals/shared_preferences.dart';
import '../routing/routes.dart';
import 'api_consumer.dart';
import 'api_status_codes.dart';
import 'base_response.dart';
import 'network_info.dart';

@LazySingleton(as: ApiConsumer)
class DioApiConsumer extends ApiConsumer {
  final Dio dioClient;
  final NetworkInfo networkInfo;
  final SharedPrefServices appPref;
  final CachedSecure cachedSecure;

  DioApiConsumer({
    required this.networkInfo,
    required this.dioClient,
    required this.cachedSecure,
    required this.appPref,
  }) {
    (dioClient.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };

    dioClient.options
      ..baseUrl = ApiConstants.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < ApiStatusCodes.internalServerError;
      };

    if (kDebugMode) {
      dioClient.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> getHeaders() async {
    String token = await cachedSecure.getToken() ?? '';
    if (token.isNotEmpty) {
      return {'Accept': 'application/json', 'Authorization': 'Bearer $token', "Content-Type": "application/json",};
    }
    return null;
  }

  @override
  Future get(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.get(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
          options: Options(headers: await getHeaders()),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future delete(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.delete(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
          options: Options(headers: await getHeaders()),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future post(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.post(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
          options: Options(headers: await getHeaders()),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }
  @override
  Future<dynamic> patch(String endPoint,
      {body, Map<String, dynamic>? queryParameters,
        bool formDataIsEnabled = false}) async{
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.patch(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body ?? {}) : body,
          options: Options(headers: await getHeaders()),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  BaseResponse handleResponseOnly({required Response response}) {
    final statusCode = response.statusCode ?? 0;

    if (statusCode > 199 && statusCode < 300) {
      return _handleResponseAsJson(response: response);
    } else if (statusCode == 401 || statusCode == 402) {
      clearDataUser();
      final decodedData = jsonDecode(response.data);
      throw ServerErrorException(decodedData['msg']);
    } else if (statusCode == 404) {
      throw NotFoundException();
    } else if (statusCode > 399 && statusCode < 500) {
      return _handleResponseAsJson(response: response);
    } else if ((statusCode >= 300 && statusCode < 400) ||
        (statusCode >= 500 && statusCode < 600)) {
      throw ServerErrorException();
    }
    throw ServerErrorException();
  }

  Future<void> clearDataUser() async {
    try {
      await cachedSecure.deleteToken();
      Thamara.appNavigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.loginView,
        (route) => false,
      );
    } catch (error) {
      throw ServerErrorException();
    }
  }

  BaseResponse _handleResponseAsJson({required Response<dynamic> response}) {
    final responseJson = jsonDecode(response.data.toString());
    return BaseResponse.fromJson(responseJson);
  }

  dynamic _handelDioError({required DioException error}) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeOutException();
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException();
      case DioExceptionType.sendTimeout:
        throw TimeOutException();
      case DioExceptionType.receiveTimeout:
        throw TimeOutException();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        if (statusCode == 401 || statusCode == 402) {
          clearDataUser();
          throw ServerErrorException();
        } else if (statusCode == 404) {
          throw NotFoundException();
        } else if ((statusCode >= 300 && statusCode < 400) ||
            (statusCode >= 500 && statusCode < 600)) {
          throw ServerErrorException();
        }
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        if (error.type.name.contains("SocketException")) {
          throw NoInternetConnectionException();
        }
        throw UnKnownException();
    }
  }
}
