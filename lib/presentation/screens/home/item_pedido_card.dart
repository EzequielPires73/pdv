import 'package:comerciou_pdv/domain/models/item_pedido.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/counter_widget.dart';
import 'package:comerciou_pdv/presentation/widgets/only_dashed_border.dart';
import 'package:flutter/material.dart';

class ItemPedidoCard extends StatelessWidget {
  final OrderViewModel orderViewModel = injec();
  final ItemPedido item;
  ItemPedidoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child:
                    item.produto.pathLocation != null
                        ? Image.network(
                          item.produto.pathLocation!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                        : Icon(Icons.image, size: 16),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.produto.nome,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Text(
                    item.modelo?.nome ?? item.produto.descricao ?? '',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            CounterWidget(
              count: item.quantidade,
              onChange: (int i) => orderViewModel.updateItemQuantity(item, i),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Unitário:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                Text('R\$ ${item.precoUn.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                Text(
                  'R\$ ${(item.precoUn * item.quantidade).toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
        OnlyDashedBorder(),
      ],
    );
  }
}
