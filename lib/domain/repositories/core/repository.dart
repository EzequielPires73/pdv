import 'package:comerciou_pdv/utils/result.dart';

abstract class IRepository<T> {
  Future<Result<List<T>>> getAll({Map<String, dynamic>? filters});
  Future<Result> create(T item);
  Future<Result> update(T item);
  Future<Result> delete(T item);
  Future<Result<T>> getOneById(dynamic id);
}
