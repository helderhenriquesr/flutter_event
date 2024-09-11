// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField()
  static const GTW_URL = _Env.GTW_URL;
}
