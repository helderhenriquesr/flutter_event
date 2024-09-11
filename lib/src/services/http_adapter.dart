import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../home/failures/http_failure.dart';

enum HttpMethod { get, post, delete, put }

abstract class HttpAdapterStatus {
  static const int ok = 200;
}

abstract class HttpAdapterInterface {
  Future<Response> request<T>({
    required HttpMethod method,
    required String path,
    dynamic data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  });
}

Future _parseJson(String text) {
  return compute(_parseAndDecode, text);
}

dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

class HttpAdapter implements HttpAdapterInterface {
  final Dio _clientHttp;
  final bool showLog;
  final String baseUrl;
  final Map<String, dynamic>? baseHeaders;

  HttpAdapter({
    required this.baseUrl,
    this.baseHeaders,
    this.showLog = true,
  }) : _clientHttp = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: baseHeaders,
            connectTimeout: const Duration(seconds: 60),
          ),
        )..interceptors.addAll([
            if (showLog)
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
              ),
            InterceptorsWrapper(
              onRequest: (request, handler) {
                return handler.next(request);
              },
              onError: (error, handler) {
                return handler.next(error);
              },
            ),
          ]);

  @override
  Future<Response> request<T>({
    required HttpMethod method,
    required String path,
    dynamic data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      String apiMethod = '';

      switch (method) {
        case HttpMethod.get:
          apiMethod = 'GET';
          break;
        case HttpMethod.post:
          apiMethod = 'POST';
          break;
        case HttpMethod.put:
          apiMethod = 'PUT';
          break;
        case HttpMethod.delete:
          apiMethod = 'DELETE';
          break;
        default:
      }

      final reponse = await clientHttp.request(
        path,
        data: data,
        queryParameters: params,
        options: Options(
          method: apiMethod,
          headers: headers,
        ),
      );

      return reponse;
    } on DioException catch (error) {
      return Future.error(HttpFailure(error.message!, error.response));
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @visibleForTesting
  Dio get clientHttp {
    (_clientHttp.transformer as BackgroundTransformer).jsonDecodeCallback =
        _parseJson;
    return _clientHttp;
  }
}
