import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/user.dart';
import 'package:comerciou_pdv/domain/repositories/user_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class UserRepositoryImp implements UserRepository {
  final ApiService api;

  UserRepositoryImp({required this.api});

  @override
  Future<Result> create(User item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result> delete(User item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<User>>> getAll({Map<String, dynamic>? filters}) async {
    try {
      var res = await api.get('Users/GetAllByName', params: filters);
      List data = res as List;
      List<User> users = data.map((e) => User.fromJson(e)).toList();

      return Result.ok(users);
    } catch (error) {
      print(error);
      return Result.error(
        Exception('Não foi possível converter a lista de usuários.'),
      );
    }
  }

  @override
  Future<Result<User>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(User item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
