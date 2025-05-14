import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/domain/repositories/core/repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

abstract class ProductRepository extends IRepository<Produto> {
  Future<Result<List<Produto>>> getAllByName({Map<String, dynamic>? filters});
}
