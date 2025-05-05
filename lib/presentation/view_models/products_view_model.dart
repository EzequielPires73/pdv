import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/domain/repositories/product_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';

class ProductsViewModel extends BaseCrudViewModel<Produto> {
  ProductsViewModel({required ProductRepository repository})
    : super(repository: repository);
}
