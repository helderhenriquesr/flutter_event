import 'package:dio/dio.dart';

class HttpFailure {
  final String message;
  final Response? response;

  HttpFailure(this.message, this.response);
}
