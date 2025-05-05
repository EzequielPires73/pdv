import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/categories_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/products_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/button.dart';
import 'package:comerciou_pdv/presentation/widgets/product_card.dart';
import 'package:comerciou_pdv/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsViewModel productsViewModel = injec();
  final CategoriesViewModel categoriesViewModel = injec();

  @override
  void initState() {
    super.initState();
    productsViewModel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: CustomColors.scaffold,
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            Expanded(
              child: Card(
                margin: EdgeInsets.zero,
                color: CustomColors.card,
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 8,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Procurar por produto...',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(maxWidth: 200),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Quantidade',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: IconButton.filled(
                                onPressed: () {},
                                icon: Icon(Icons.search),
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Colors.black12),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Categorias',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ListenableBuilder(
                              listenable: categoriesViewModel,
                              builder: (context, child) {
                                if (categoriesViewModel.load.running) {
                                  return CircularProgressIndicator();
                                }
                                if (categoriesViewModel.load.error) {
                                  return Center(
                                    child: Text('Erro ao carregar categorias.'),
                                  );
                                }
                                if (categoriesViewModel.load.completed &&
                                    categoriesViewModel.items != null &&
                                    categoriesViewModel.items!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Nenhuma categoria encontrada.',
                                    ),
                                  );
                                }
                                List<Categoria> items =
                                    categoriesViewModel.items ?? [];

                                return Wrap(
                                  spacing: 8,
                                  children:
                                      items
                                          .map(
                                            (e) => FilterChip(
                                              label: Text(e.nome),
                                              selected: e.id == 1,
                                              onSelected: (value) {},
                                            ),
                                          )
                                          .toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Colors.black12),
                      Expanded(
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
                                ListenableBuilder(
                                  listenable: productsViewModel,
                                  builder: (context, child) {
                                    if (productsViewModel.load.running) {
                                      return CircularProgressIndicator();
                                    }
                                    if (productsViewModel.load.error) {
                                      return Center(
                                        child: Text(
                                          'Erro ao carregar produtos.',
                                        ),
                                      );
                                    }
                                    if (productsViewModel.load.completed &&
                                        productsViewModel.items != null &&
                                        productsViewModel.items!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'Nenhum produto encontrado.',
                                        ),
                                      );
                                    }
                                    List<Produto> items =
                                        productsViewModel.items ?? [];

                                    return Wrap(
                                      spacing: 8,
                                      runSpacing: 16,
                                      children:
                                          items
                                              .map(
                                                (e) => ProductCard(product: e),
                                              )
                                              .toList(),
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
              ),
            ),
            Container(
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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            hintText: 'Cliente',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 1, color: Colors.black12),
                      Expanded(
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
                                Text(
                                  'Nenhum produto selecionado',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 1, color: Colors.black12),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          spacing: 8,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Subtotal'),
                                Text(
                                  'R\$ 5.000,00',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Desconto'),
                                Text(
                                  'R\$ 200,00',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total'),
                                Text(
                                  'R\$ 4.800,00',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Colors.black12),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Button(label: 'Continuar', onPressed: () {}),
                          ],
                        ),
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
