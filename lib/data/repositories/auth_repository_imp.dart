import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/repositories/auth_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImp implements AuthRepository {
  final ApiService api;

  AuthRepositoryImp({required this.api});

  @override
  Future<Result<dynamic>> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    if (accessToken != null) {
      api.setToken(accessToken);
      return Result.ok({});
    } else {
      return Result.error(Exception('Usuário não está logado.'));
    }
  }

  @override
  Future<Result<dynamic>> signin(String email, String password) async {
    try {
      var res = await api.post(
        'Users/authenticate',
        data: {'email': email, 'password': password},
      );

      if (res['token'] == null) {
        return Result.error(Exception());
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = res['token'];
      api.setToken(token);
      prefs.setString('token', token);

      return Result.ok({});
    } catch (error) {
      return Result.error(Exception(error.toString()));
    }
  }

  @override
  Future<void> signout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
