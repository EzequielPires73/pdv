import 'package:comerciou_pdv/data/repositories/category_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/product_repository_imp.dart';
import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/repositories/category_repository.dart';
import 'package:comerciou_pdv/domain/repositories/product_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/categories_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/products_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final injec = GetIt.instance;

Future<void> initInjec() async {
  injec.registerLazySingleton<Dio>(() => Dio());

  injec.registerLazySingleton<ApiService>(() => ApiService(dio: injec()));

  injec.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<ProductsViewModel>(
    () => ProductsViewModel(repository: injec()),
  );

  injec.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<CategoriesViewModel>(
    () => CategoriesViewModel(repository: injec()),
  );

  injec.registerLazySingleton<OrderViewModel>(() => OrderViewModel());
}
