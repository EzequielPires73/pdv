import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/models/item_pedido.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/screens/home/product_select.dart';
import 'package:comerciou_pdv/presentation/view_models/categories_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/order_view_model.dart';
import 'package:comerciou_pdv/presentation/view_models/products_view_model.dart';
import 'package:comerciou_pdv/presentation/widgets/custom_text_field.dart';
import 'package:comerciou_pdv/presentation/widgets/product_card.dart';
import 'package:comerciou_pdv/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProdutoSection extends StatefulWidget {
  const ProdutoSection({super.key});

  @override
  State<ProdutoSection> createState() => _ProdutoSectionState();
}

class _ProdutoSectionState extends State<ProdutoSection> {
  final ProductsViewModel productsViewModel = injec();
  final OrderViewModel orderViewModel = injec();
  final SearchController productController = SearchController();
  final CategoriesViewModel categoriesViewModel = injec();
  final TextEditingController quantity = TextEditingController();
  Produto? produto;

  @override
  void initState() {
    super.initState();
    productsViewModel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: ProductSelect(
                        controller: productController,
                        onChange: (value) {
                          setState(() {
                            produto = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: 200),
                      child: CustomTextField(
                        controller: quantity,
                        label: 'Quantidade',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: IconButton.filled(
                        onPressed:
                            produto != null
                                ? () {
                                  orderViewModel.addItem(
                                    ItemPedido(
                                      idProduto: produto!.id!,
                                      precoTotal:
                                          quantity.text.isNotEmpty
                                              ? int.parse(quantity.text) *
                                                  produto!.valor
                                              : produto!.valor,
                                      precoUn: produto!.valor,
                                      quantidade:
                                          quantity.text.isNotEmpty
                                              ? int.parse(quantity.text)
                                              : 1,
                                      produto: produto!,
                                    ),
                                  );
                                  setState(() {
                                    produto = null;
                                  });
                                  quantity.text = '1';
                                  productController.clear();
                                }
                                : null,
                        icon: Icon(Icons.arrow_forward),
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
                            child: Text('Nenhuma categoria encontrada.'),
                          );
                        }
                        List<Categoria> items = categoriesViewModel.items ?? [];

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
                                child: Text('Erro ao carregar produtos.'),
                              );
                            }
                            if (productsViewModel.load.completed &&
                                productsViewModel.items != null &&
                                productsViewModel.items!.isEmpty) {
                              return Center(
                                child: Text('Nenhum produto encontrado.'),
                              );
                            }
                            List<Produto> items = productsViewModel.items ?? [];

                            return Wrap(
                              spacing: 8,
                              runSpacing: 16,
                              children:
                                  items
                                      .map((e) => ProductCard(product: e))
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
    );
  }
}
