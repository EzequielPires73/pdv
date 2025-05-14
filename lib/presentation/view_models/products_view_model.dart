import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/domain/repositories/product_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';
import 'package:comerciou_pdv/utils/command.dart';
import 'package:comerciou_pdv/utils/result.dart';

class ProductsViewModel extends BaseCrudViewModel<Produto> {
  final ProductRepository productRepository;

  ProductsViewModel({required this.productRepository})
    : super(repository: productRepository) {
    getByName = Command1(_getByName);
  }
  late final Command1<void, Map<String, dynamic>> getByName;
  List<Produto> filtered = [];

  Future<Result> _getByName(Map<String, dynamic> params) async {
    try {
      final result = await productRepository.getAllByName(filters: params);

      switch (result) {
        case Ok<List<Produto>>():
          filtered = result.value;
        case Error<List<Produto>>():
          filtered = [];
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
