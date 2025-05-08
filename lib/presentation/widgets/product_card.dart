import 'package:comerciou_pdv/domain/models/item_pedido.dart';
import 'package:comerciou_pdv/domain/models/modelo.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final OrderViewModel orderViewModel = injec();
  final Produto product;
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - (420 + 104)) / 4;

    return Card.filled(
      color: Colors.white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (product.modelos.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) => ModalAddProduct(product: product),
            );
          } else {
            int quantity =
                orderViewModel.quantity.text.isNotEmpty
                    ? int.parse(orderViewModel.quantity.text)
                    : 1;
            orderViewModel.addItem(
              ItemPedido(
                idProduto: product.id!,
                precoTotal: product.valor * quantity,
                precoUn: product.valor,
                quantidade: quantity,
                produto: product,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          width: width,
          constraints: BoxConstraints(minWidth: 164),
          child: Row(
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
                      product.pathLocation != null
                          ? Image.network(
                            product.pathLocation!,
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
                  children: [
                    Text(
                      product.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'R\$ ${product.valor}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalAddProduct extends StatefulWidget {
  final Produto product;
  const ModalAddProduct({super.key, required this.product});

  @override
  State<ModalAddProduct> createState() => _ModalAddProductState();
}

class _ModalAddProductState extends State<ModalAddProduct> {
  final OrderViewModel orderViewModel = injec();
  int quantidade = 1;
  Modelo? modeloSelecionado;

  @override
  void initState() {
    super.initState();
    if (widget.product.modelos.isNotEmpty) {
      modeloSelecionado = widget.product.modelos.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    double valorFinal = modeloSelecionado?.valor ?? widget.product.valor;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 8,
              children: [
                if (widget.product.pathLocation != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.product.pathLocation!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.descricao ?? '',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (widget.product.modelos.isNotEmpty)
              ...widget.product.modelos.map(
                (e) => RadioListTile(
                  value: e,
                  groupValue: modeloSelecionado,
                  title: Text('${e.nome} - R\$ ${e.valor.toStringAsFixed(2)}'),
                  onChanged: (value) {
                    setState(() {
                      modeloSelecionado = value;
                    });
                  },
                ),
              ),
            const SizedBox(height: 16),

            // Quantidade
            Row(
              children: [
                const Text('Quantidade:'),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantidade > 1) {
                      setState(() => quantidade--);
                    }
                  },
                ),
                Text('$quantidade', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() => quantidade++);
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Preço final
            Text(
              'Total: R\$ ${(valorFinal * quantidade).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  label: 'Cancelar',
                  full: false,
                  onPressed: () => Navigator.pop(context),
                  variant: ButtonVariant.text,
                ),
                const SizedBox(width: 12),
                Button(
                  label: 'Adicionar',
                  full: false,
                  onPressed: () {
                    Produto product = widget.product;
                    orderViewModel.addItem(
                      ItemPedido(
                        idProduto: product.id!,
                        modelo: modeloSelecionado,
                        idModeloProduto: modeloSelecionado?.id,
                        precoTotal:
                            modeloSelecionado != null
                                ? modeloSelecionado!.valor * quantidade
                                : product.valor * quantidade,
                        precoUn:
                            modeloSelecionado != null
                                ? modeloSelecionado!.valor
                                : product.valor,
                        quantidade: quantidade,
                        produto: product,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
