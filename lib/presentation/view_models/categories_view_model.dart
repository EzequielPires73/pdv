import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/repositories/category_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';

class CategoriesViewModel extends BaseCrudViewModel<Categoria> {
  CategoriesViewModel({required CategoryRepository repository})
    : super(repository: repository);
}
