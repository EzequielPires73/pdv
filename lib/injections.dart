import 'package:comerciou_pdv/data/repositories/category_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/client_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/order_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/payment_method_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/product_repository_imp.dart';
import 'package:comerciou_pdv/data/repositories/user_repository_imp.dart';
import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/repositories/category_repository.dart';
import 'package:comerciou_pdv/domain/repositories/client_repository.dart';
import 'package:comerciou_pdv/domain/repositories/order_repository.dart';
import 'package:comerciou_pdv/domain/repositories/payment_method_repository.dart';
import 'package:comerciou_pdv/domain/repositories/product_repository.dart';
import 'package:comerciou_pdv/domain/repositories/user_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/categories_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/clients_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/payment_mothods_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/products_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/users_view_model.dart';
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

  injec.registerLazySingleton<ClientRepository>(
    () => ClientRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<ClientsViewModel>(
    () => ClientsViewModel(repository: injec()),
  );

  injec.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<UsersViewModel>(
    () => UsersViewModel(repository: injec()),
  );

  injec.registerLazySingleton<PaymentMethodRepository>(
    () => PaymentMethodRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<PaymentMothodsViewModel>(
    () => PaymentMothodsViewModel(repository: injec()),
  );

  injec.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImp(api: injec()),
  );

  injec.registerLazySingleton<OrderViewModel>(
    () => OrderViewModel(repository: injec()),
  );
}
