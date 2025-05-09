import 'package:comerciou_pdv/core/error/exceptions.dart';
import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/pedido.dart';
import 'package:comerciou_pdv/domain/repositories/order_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class OrderRepositoryImp implements OrderRepository {
  final ApiService api;

  OrderRepositoryImp({required this.api});

  @override
  Future<Result> create(Pedido item) async {
    try {
      print(item.toJson());
      var res = await api.post('venda', data: item.toJson());

      return Result.ok(res);
    } on ServerException catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result> delete(Pedido item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Pedido>>> getAll({Map<String, dynamic>? filters}) async {
    try {
      var res = await api.get(
        'venda/paged?pageNumber=1&pageSize=10',
        params: filters,
      );
      List data = res['results'] as List;
      List<Pedido> products = data.map((e) => Pedido.fromJson(e)).toList();

      return Result.ok(products);
    } catch (error) {
      print(error);
      return Result.error(
        Exception('Não foi possível converter a lista de clientes.'),
      );
    }
  }

  @override
  Future<Result<Pedido>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(Pedido item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
