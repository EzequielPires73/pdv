import 'package:comerciou_pdv/data/services/api_service.dart';
import 'package:comerciou_pdv/domain/models/forma_pagamento.dart';
import 'package:comerciou_pdv/domain/repositories/payment_method_repository.dart';
import 'package:comerciou_pdv/utils/result.dart';

class PaymentMethodRepositoryImp implements PaymentMethodRepository {
  final ApiService api;

  PaymentMethodRepositoryImp({required this.api});

  @override
  Future<Result> create(FormaPagamento item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result> delete(FormaPagamento item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<FormaPagamento>>> getAll({
    Map<String, dynamic>? filters,
  }) async {
    try {
      var res = await api.get('FormaPagamento/GetAllList', params: filters);
      List data = res as List;
      List<FormaPagamento> products =
          data.map((e) => FormaPagamento.fromJson(e)).toList();

      return Result.ok(products);
    } catch (error) {
      return Result.error(
        Exception(
          'Não foi possível converter a lista de formas de pagamentos.',
        ),
      );
    }
  }

  @override
  Future<Result<FormaPagamento>> getOneById(id) {
    // TODO: implement getOneById
    throw UnimplementedError();
  }

  @override
  Future<Result> update(FormaPagamento item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
