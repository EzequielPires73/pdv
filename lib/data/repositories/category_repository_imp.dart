import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/repositories/category_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class CategoryRepositoryImp implements CategoryRepository {
  final ApiService api;

  CategoryRepositoryImp({required this.api});

  @override
  Future<Result> create(Categoria item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result> delete(Categoria item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Categoria>>> getAll({
    Map<String, dynamic>? filters,
  }) async {
    try {
      var res = await api.get(
        'Categorias/getallcategorias?pageNumber=1&pageSize=12',
      );

      List data = res['data'] as List;
      List<Categoria> categories =
          data.map((e) => Categoria.fromJson(e)).toList();

      return Result.ok(categories);
    } catch (error) {
      return Result.error(
        Exception('Não foi possível converter a lista de categorias.'),
      );
    }
  }

  @override
  Future<Result<Categoria>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(Categoria item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
