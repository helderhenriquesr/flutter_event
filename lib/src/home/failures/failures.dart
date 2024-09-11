import 'package:suricato_app/src/home/failures/error_handler_failure.dart';

abstract class MoviesFailure implements ErrorHandlerFailure {}

class APIMoviesFailure extends MoviesFailure {
  @override
  final String message;
  @override
  final FailureType type;
  @override
  final FailureDisplayType displayType;
  @override
  final String? title;
  @override
  final void Function()? onPress;

  APIMoviesFailure({
    required this.message,
    required this.type,
    required this.displayType,
    this.title,
    this.onPress,
  }) : super();
}

class GetCurrentLocationFailure extends MoviesFailure {
  @override
  final String message;
  @override
  FailureType get type => FailureType.error;
  @override
  FailureDisplayType get displayType => FailureDisplayType.toast;
  @override
  final String? title;
  @override
  final void Function()? onPress;

  GetCurrentLocationFailure({
    required this.message,
    this.title,
    this.onPress,
  }) : super();
}

class MovieFailure extends MoviesFailure {
  @override
  final String message;
  @override
  FailureType get type => FailureType.error;
  @override
  FailureDisplayType get displayType => FailureDisplayType.dialog;
  @override
  final String? title;
  @override
  final void Function()? onPress;

  MovieFailure({
    required this.message,
    this.title,
    this.onPress,
  }) : super();
}

class NetworkMoviesFailure extends MoviesFailure {
  @override
  FailureDisplayType get displayType => FailureDisplayType.toast;
  @override
  final String message;
  @override
  void Function()? get onPress => null;
  @override
  String? get title => null;
  @override
  FailureType get type => FailureType.warning;

  NetworkMoviesFailure({required this.message}) : super();
}

class SearchAddressesFailure extends MoviesFailure {
  @override
  final String message;
  @override
  FailureType get type => FailureType.error;
  @override
  FailureDisplayType get displayType => FailureDisplayType.toast;
  @override
  final String? title;
  @override
  final void Function()? onPress;

  SearchAddressesFailure({
    required this.message,
    this.title,
    this.onPress,
  }) : super();
}
