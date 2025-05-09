import 'package:comerciou_pdv/domain/models/cliente.dart';
import 'package:comerciou_pdv/domain/models/forma_pagamento.dart';
import 'package:comerciou_pdv/domain/models/item_pedido.dart';
import 'package:comerciou_pdv/domain/models/pedido.dart';
import 'package:comerciou_pdv/domain/repositories/order_repository.dart';
import 'package:comerciou_pdv/presentation/view_models/core/base_crud_view_model.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends BaseCrudViewModel<Pedido> {
  Pedido? pedido;
  TextEditingController quantity = TextEditingController(text: '1');

  OrderViewModel({required OrderRepository repository})
    : super(repository: repository);

  setClient(Cliente? client) {
    if (pedido != null) {
      pedido!.idClient = client?.id;
    }
    notifyListeners();
  }

  setPaymentMethod(FormaPagamento? paymentMethod) {
    if (pedido != null) {
      pedido!.idFormaPagamento = paymentMethod?.id;
    }
    notifyListeners();
  }

  addItem(ItemPedido item) {
    try {
      if (pedido != null) {
        if (pedido!.vendaProdutos != null) {
          pedido!.valorTotal = pedido!.valorTotal + item.precoTotal;
          pedido!.vendaProdutos!.add(item);
        } else {
          pedido!.vendaProdutos = [item];
        }
      } else {
        pedido = Pedido(
          data: DateTime.now(),
          valorTotal: item.precoTotal,
          vendaProdutos: [item],
        );
      }
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }

  void updateItemQuantity(ItemPedido item, int newQuantity) {
    if (pedido == null || pedido!.vendaProdutos == null) return;

    final index = pedido!.vendaProdutos!.indexOf(item);
    if (index != -1) {
      if (newQuantity <= 0) {
        pedido!.vendaProdutos?.remove(item);
        double valorTotal =
            pedido!.vendaProdutos?.fold(0.0, (a, b) => a! + b.precoTotal) ?? 0;
        pedido!.valorTotal = valorTotal;
        notifyListeners();
        return;
      }
      final oldItem = pedido!.vendaProdutos![index];
      pedido!.valorTotal -= oldItem.precoTotal;

      final updatedItem = oldItem.copyWith(
        quantidade: newQuantity,
        precoTotal: oldItem.precoUn * newQuantity,
      );

      pedido!.vendaProdutos![index] = updatedItem;
      double valorTotal =
          pedido!.vendaProdutos?.fold(0.0, (a, b) => a! + b.precoTotal) ?? 0;
      pedido!.valorTotal = valorTotal;

      notifyListeners();
    }
  }
}
