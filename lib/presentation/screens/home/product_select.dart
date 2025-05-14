import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/products_view_model.dart';
import 'package:flutter/material.dart';

class ProductSelect extends StatelessWidget {
  final ProductsViewModel viewModel = injec();
  final Function(Produto produto) onChange;
  final SearchController controller;
  ProductSelect({super.key, required this.onChange, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Text('Produto', style: TextStyle(fontWeight: FontWeight.w600)),
            SearchAnchor.bar(
              searchController: controller,
              barBackgroundColor: WidgetStatePropertyAll(Colors.white),
              constraints: BoxConstraints.tightFor(height: 48),
              barShape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(width: 1, color: Colors.black26),
                ),
              ),
              barElevation: WidgetStatePropertyAll(0),
              viewHeaderHeight: 48,
              viewShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              viewBackgroundColor: Colors.white,
              barHintText: 'Selecionar produto',
              suggestionsBuilder: (context, _) async {
                if (controller.text.isNotEmpty) {
                  await viewModel.getByName.execute({'nome': controller.text});
                }

                if (viewModel.getByName.running) {
                  return [const Center(child: CircularProgressIndicator())];
                }

                final produtos = viewModel.filtered ?? [];

                if (produtos.isEmpty) {
                  return [
                    const ListTile(title: Text('Nenhum produto encontrado')),
                  ];
                }

                return produtos.map<Widget>((item) {
                  return ListTile(
                    title: Text(item.nome),
                    onTap: () {
                      controller.text = item.nome;
                      controller.closeView(item.nome);
                      onChange(item);
                    },
                  );
                }).toList();
              },
            ),
          ],
        );
      },
    );
  }
}
