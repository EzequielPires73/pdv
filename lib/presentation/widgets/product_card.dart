import 'dart:convert';
import 'dart:typed_data';

import 'package:comerciou_pdv/domain/models/modelo.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Produto product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - (420 + 104)) / 4;
    final String base64Data =
        product.fotoThumbnail.contains(',')
            ? product.fotoThumbnail.split(',')[1]
            : product.fotoThumbnail;

    Uint8List bytes = base64Decode(base64Data);

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ModalAddProduct(product: product),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          width: width,
          constraints: BoxConstraints(minWidth: 164),
          child: Column(
            spacing: 2,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  bytes,
                  width: double.infinity,
                  height: 148,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                product.nome,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                'R\$ ${product.valor}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
    final String base64Data =
        widget.product.fotoThumbnail.contains(',')
            ? widget.product.fotoThumbnail.split(',')[1]
            : widget.product.fotoThumbnail;
    Uint8List bytes = base64Decode(base64Data);

    double valorFinal = modeloSelecionado?.valor ?? widget.product.valor;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Imagem do produto
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                bytes,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Nome e descrição
            Text(
              widget.product.nome,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.descricao,
              style: TextStyle(color: Colors.grey[700]),
            ),

            const SizedBox(height: 16),

            // Modelos (se existirem)
            if (widget.product.modelos.isNotEmpty) ...[
              const Text('Selecione o modelo'),
              DropdownButton<Modelo>(
                isExpanded: true,
                value: modeloSelecionado,
                onChanged: (value) {
                  setState(() {
                    modeloSelecionado = value;
                  });
                },
                items:
                    widget.product.modelos.map((modelo) {
                      return DropdownMenuItem(
                        value: modelo,
                        child: Text(
                          '${modelo.nome} - R\$ ${modelo.valor.toStringAsFixed(2)}',
                        ),
                      );
                    }).toList(),
              ),
            ],

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
                    // Aqui você pode enviar os dados selecionados (quantidade, modelo) para o carrinho ou fluxo desejado.
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
