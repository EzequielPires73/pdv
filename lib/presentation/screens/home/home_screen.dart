import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/screens/home/pedido_section.dart';
import 'package:comerciou_pdv/presentation/screens/home/produto_section.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: CustomColors.scaffold,
        padding: const EdgeInsets.all(16),
        child: Row(spacing: 16, children: [ProdutoSection(), PedidoSection()]),
      ),
    );
  }
}
