import 'package:comerciou_pdv/domain/models/forma_pagamento.dart';
import 'package:comerciou_pdv/domain/repositories/payment_method_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';

class PaymentMothodsViewModel extends BaseCrudViewModel<FormaPagamento> {
  PaymentMothodsViewModel({required PaymentMethodRepository repository})
    : super(repository: repository);
}
