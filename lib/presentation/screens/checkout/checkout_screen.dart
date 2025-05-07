import 'package:comerciou_pdv/domain/models/pedido.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
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
  PaymentMethod? paymentMethod = PaymentMethod.dinheiro;

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
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: TextEditingController(),
                                    label: 'Nome',
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    controller: TextEditingController(),
                                    label: 'CPF/CNPJ',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: TextEditingController(),
                                    label: 'Email',
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    controller: TextEditingController(),
                                    label: 'Telefone',
                                  ),
                                ),
                              ],
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
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: PaymentMethod.dinheiro,
                                    groupValue: paymentMethod,
                                    title: Text(PaymentMethod.dinheiro.name()),
                                    onChanged:
                                        (value) => setState(() {
                                          paymentMethod = value;
                                        }),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    value: PaymentMethod.pix,
                                    groupValue: paymentMethod,
                                    title: Text(PaymentMethod.pix.name()),
                                    onChanged:
                                        (value) => setState(() {
                                          paymentMethod = value;
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: PaymentMethod.cartaoCredito,
                                    groupValue: paymentMethod,
                                    title: Text(
                                      PaymentMethod.cartaoCredito.name(),
                                    ),
                                    onChanged:
                                        (value) => setState(() {
                                          paymentMethod = value;
                                        }),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    value: PaymentMethod.cartaoDebito,
                                    groupValue: paymentMethod,
                                    title: Text(
                                      PaymentMethod.cartaoDebito.name(),
                                    ),
                                    onChanged:
                                        (value) => setState(() {
                                          paymentMethod = value;
                                        }),
                                  ),
                                ),
                              ],
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
                          return Column(
                            children: [
                              Button(
                                label: 'Finalizar',
                                variant: ButtonVariant.success,
                                onPressed: () {},
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
