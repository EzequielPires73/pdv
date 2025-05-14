import 'package:comerciou_pdv/utils/result.dart';

abstract class AuthRepository {
  Future<Result> load();
  Future<Result> signin(String email, String password);
  Future<void> signout();
}
