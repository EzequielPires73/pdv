import 'package:comerciou_pdv/domain/models/cliente.dart';
import 'package:comerciou_pdv/domain/repositories/client_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';
import 'package:comerciou_pdv/utils/command.dart';
import 'package:comerciou_pdv/utils/result.dart';

class ClientsViewModel extends BaseCrudViewModel<Cliente> {
  late final Command1<void, String> getByName;

  ClientsViewModel({required ClientRepository repository})
    : super(repository: repository) {
    getByName = Command1(_getByName);
  }

  Future<Result> _getByName(String nome) async {
    try {
      final result = await repository.getAll(filters: {'nome': nome});
      print(result);
      switch (result) {
        case Ok<List<Cliente>>():
          items = result.value;
        case Error<List<Cliente>>():
          items = [];
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
