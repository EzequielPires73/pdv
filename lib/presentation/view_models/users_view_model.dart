import 'package:comerciou_pdv/domain/models/user.dart';
import 'package:comerciou_pdv/domain/repositories/user_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';
import 'package:comerciou_pdv/utils/command.dart';
import 'package:comerciou_pdv/utils/result.dart';

class UsersViewModel extends BaseCrudViewModel<User> {
  late final Command1<void, String> getByName;

  UsersViewModel({required UserRepository repository})
    : super(repository: repository) {
    getByName = Command1(_getByName);
  }

  Future<Result> _getByName(String nome) async {
    try {
      final result = await repository.getAll(filters: {'nome': nome});
      print(result);
      switch (result) {
        case Ok<List<User>>():
          items = result.value;
        case Error<List<User>>():
          items = [];
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
