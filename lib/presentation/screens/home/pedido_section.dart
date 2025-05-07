import 'package:comerciou_pdv/domain/models/pedido.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/screens/checkout/checkout_screen.dart';
import 'package:comerciou_pdv/presentation/screens/home/item_pedido_card.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:comerciou_pdv/presentation/widgets/only_dashed_border.dart';
import 'package:comerciou_pdv/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class PedidoSection extends StatefulWidget {
  const PedidoSection({super.key});

  @override
  State<PedidoSection> createState() => _PedidoSectionState();
}

class _PedidoSectionState extends State<PedidoSection> {
  final OrderViewModel orderViewModel = injec();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 420),
      child: Card(
        margin: EdgeInsets.zero,
        color: CustomColors.card,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListenableBuilder(
                listenable: orderViewModel,
                builder: (context, child) {
                  Pedido? pedido = orderViewModel.pedido;
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Produtos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            pedido == null ||
                                    pedido.vendaProdutos == null ||
                                    pedido.vendaProdutos!.isEmpty
                                ? Text(
                                  'Nenhum produto selecionado',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                                : Column(
                                  children:
                                      pedido.vendaProdutos!
                                          .map((e) => ItemPedidoCard(item: e))
                                          .toList(),
                                ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Divider(height: 1, color: Colors.black12),
              ListenableBuilder(
                listenable: orderViewModel,
                builder: (context, child) {
                  Pedido? pedido = orderViewModel.pedido;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal'),
                            Text(
                              'R\$ ${pedido?.valorTotal.toStringAsFixed(2) ?? 0.00}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Desconto'),
                            Text(
                              'R\$ 0.00',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        OnlyDashedBorder(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text(
                              'R\$ ${pedido?.valorTotal.toStringAsFixed(2) ?? 0.00}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Divider(height: 1, color: Colors.black12),
              ListenableBuilder(
                listenable: orderViewModel,
                builder: (context, child) {
                  Pedido? pedido = orderViewModel.pedido;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Button(
                          label: 'Continuar',
                          onPressed:
                              pedido != null &&
                                      pedido.vendaProdutos != null &&
                                      pedido.vendaProdutos!.isNotEmpty
                                  ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              CheckoutScreen(pedido: pedido),
                                    ),
                                  )
                                  : null,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
