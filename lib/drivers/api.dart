import 'package:dio/dio.dart';
import 'package:frontend_mobile/config.dart';
import 'package:get_it/get_it.dart';

class APIDriver {
  static Dio init() {
    var config = GetIt.I.get<Config>();

    var api = Dio(
      BaseOptions(
        baseUrl: config.backend,
      ),
    );
    return api;
  }
}
