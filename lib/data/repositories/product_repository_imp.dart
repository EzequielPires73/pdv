import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/domain/repositories/product_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class ProductRepositoryImp implements ProductRepository {
  final ApiService api;

  ProductRepositoryImp({required this.api});

  @override
  Future<Result> create(Produto item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result> delete(Produto item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Produto>>> getAll({Map<String, dynamic>? filters}) async {
    try {
      var res = await api.get(
        'Produtos/getallprodutos?pageNumber=1&pageSize=12',
      );

      List data = res['items'] as List;
      List<Produto> products = data.map((e) => Produto.fromJson(e)).toList();

      return Result.ok(products);
    } catch (error) {
      return Result.error(
        Exception('Não foi possível converter a lista de produtos.'),
      );
    }
  }

  @override
  Future<Result<Produto>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(Produto item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
