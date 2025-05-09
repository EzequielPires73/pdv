import 'package:comerciou_pdv/domain/models/cliente.dart';
import 'package:comerciou_pdv/domain/models/forma_pagamento.dart';
import 'package:comerciou_pdv/domain/models/pedido.dart';
import 'package:comerciou_pdv/domain/models/user.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/screens/checkout/client_select.dart';
import 'package:comerciou_pdv/presentation/screens/checkout/user_select.dart';
import 'package:comerciou_pdv/presentation/view_models/clients_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/payment_mothods_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:comerciou_pdv/presentation/widgets/custom_text_field.dart';
import 'package:comerciou_pdv/presentation/widgets/only_dashed_border.dart';
import 'package:comerciou_pdv/utils/custom_colors.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { dinheiro, cartaoCredito, cartaoDebito, pix }

extension PaymentMethodExtension on PaymentMethod {
  String name() {
    switch (this) {
      case PaymentMethod.pix:
        return 'Pix';
      case PaymentMethod.cartaoCredito:
        return 'Cartão de Crédito';
      case PaymentMethod.cartaoDebito:
        return 'Cartão de Débito';
      default:
        return 'Dinheiro';
    }
  }
}

class CheckoutScreen extends StatefulWidget {
  final Pedido pedido;
  const CheckoutScreen({super.key, required this.pedido});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final OrderViewModel orderViewModel = injec();
  final ClientsViewModel clientsViewModel = injec();
  final PaymentMothodsViewModel paymentMothodsViewModel = injec();
  FormaPagamento? paymentMethod;
  Cliente? client;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Checkout'),
      ),
      body: Container(
        height: double.infinity,
        color: CustomColors.scaffold,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  spacing: 16,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      color: CustomColors.card,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dados do Cliente',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Informações do cliente (opcional)'),
                            const SizedBox(height: 8),
                            ClientSelect(
                              onChange: (value) {
                                setState(() {
                                  client = value;
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            UserSelect(
                              onChange: (value) {
                                setState(() {
                                  user = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      color: CustomColors.card,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forma de Pagamento',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Selecione a forma de pagamento'),
                            const SizedBox(height: 8),
                            ListenableBuilder(
                              listenable: paymentMothodsViewModel,
                              builder: (context, child) {
                                if (paymentMothodsViewModel.load.running) {
                                  return CircularProgressIndicator();
                                }
                                if (paymentMothodsViewModel.load.error) {
                                  return Center(
                                    child: Text(
                                      'Erro ao carregar formas de pagamento.',
                                    ),
                                  );
                                }
                                if (paymentMothodsViewModel.load.completed &&
                                    paymentMothodsViewModel.items != null &&
                                    paymentMothodsViewModel.items!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Nenhuma categoria encontrada.',
                                    ),
                                  );
                                }
                                List<FormaPagamento> items =
                                    paymentMothodsViewModel.items ?? [];

                                return Column(
                                  children:
                                      items
                                          .map(
                                            (e) => Card.outlined(
                                              clipBehavior: Clip.antiAlias,
                                              color:
                                                  paymentMethod?.id != e.id
                                                      ? Colors.transparent
                                                      : null,
                                              child:
                                                  RadioListTile<FormaPagamento>(
                                                    value: e,
                                                    groupValue: paymentMethod,
                                                    title: Text(e.nome),
                                                    onChanged:
                                                        (value) => setState(() {
                                                          paymentMethod = value;
                                                        }),
                                                  ),
                                            ),
                                          )
                                          .toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      color: CustomColors.card,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Observações',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Informações adicionais para a venda'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: TextEditingController(),
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Card(
                margin: EdgeInsets.zero,
                color: CustomColors.card,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumo da Venda',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${widget.pedido.vendaProdutos?.length ?? 0} itens no carrinho',
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              widget.pedido.vendaProdutos == null ||
                                      widget.pedido.vendaProdutos!.isEmpty
                                  ? Text(
                                    'Nenhum produto selecionado',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                  : Column(
                                    spacing: 8,
                                    children:
                                        widget.pedido.vendaProdutos!
                                            .map(
                                              (e) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.produto.nome,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${e.quantidade} x R\$ ${e.precoUn.toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'R\$ ${(e.precoUn * e.quantidade).toStringAsFixed(2)}',
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                  ),
                        ),
                      ),
                      Divider(height: 24, color: Colors.black12),
                      ListenableBuilder(
                        listenable: orderViewModel,
                        builder: (context, child) {
                          Pedido? pedido = orderViewModel.pedido;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal'),
                                  Text(
                                    'R\$ ${pedido?.valorTotal.toStringAsFixed(2) ?? 0.00}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Desconto'),
                                  Text(
                                    'R\$ 0.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              OnlyDashedBorder(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total'),
                                  Text(
                                    'R\$ ${pedido?.valorTotal.toStringAsFixed(2) ?? 0.00}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Divider(height: 32, color: Colors.black12),
                      ListenableBuilder(
                        listenable: orderViewModel,
                        builder: (context, child) {
                          Pedido? pedido = orderViewModel.pedido;
                          pedido?.idClient = client?.id;
                          pedido?.idFormaPagamento = paymentMethod?.id;
                          pedido?.idUser = user?.id;
                          return Column(
                            children: [
                              Button(
                                label: 'Finalizar',
                                variant: ButtonVariant.success,
                                onPressed:
                                    pedido != null &&
                                            client != null &&
                                            paymentMethod != null &&
                                            user != null
                                        ? () => orderViewModel.create.execute(
                                          pedido,
                                        )
                                        : null,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
