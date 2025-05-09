import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/cliente.dart';
import 'package:comerciou_pdv/domain/repositories/client_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class ClientRepositoryImp implements ClientRepository {
  final ApiService api;

  ClientRepositoryImp({required this.api});

  @override
  Future<Result> create(Cliente item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result> delete(Cliente item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Cliente>>> getAll({Map<String, dynamic>? filters}) async {
    try {
      var res = await api.get('Clientes/GetAllByName', params: filters);
      List data = res as List;
      List<Cliente> products = data.map((e) => Cliente.fromJson(e)).toList();

      return Result.ok(products);
    } catch (error) {
      print(error);
      return Result.error(
        Exception('Não foi possível converter a lista de clientes.'),
      );
    }
  }

  @override
  Future<Result<Cliente>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(Cliente item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
