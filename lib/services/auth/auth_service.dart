import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

part './auth_model.dart';

class AuthService {
  static Future<String?> login(Login input) async {
    final api = GetIt.I.get<Dio>();
    final response = await api.post('/auth/login', data: input.toJson());
    final data = response.data['data'];
    return data?.toString();
  }

  static Future<String?> register(Register input) async {
    final api = GetIt.I.get<Dio>();
    final response = await api.post('/auth/register', data: input.toJson());
    final data = response.data['data'];
    return data?.toString();
  }
}
