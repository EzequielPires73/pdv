import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:comerciou_pdv/presentation/screens/home/pedido_section.dart';
import 'package:comerciou_pdv/presentation/screens/home/produto_section.dart';
import 'package:comerciou_pdv/utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthViewModel authViewModel = injec();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comerciou PDV'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => authViewModel.signout.execute(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Usuário: João',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Empresa: Padaria Boa Massa',
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.point_of_sale, 'PDV', 0),
            _buildDrawerItem(Icons.history, 'Histórico de Vendas', 1),
            _buildDrawerItem(Icons.shopping_bag, 'Produtos', 2),
            _buildDrawerItem(Icons.people, 'Clientes', 3),
            const Spacer(),
            const Divider(),
            _buildDrawerItem(Icons.logout, 'Sair', 99, isLogout: true),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        color: CustomColors.scaffold,
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: const [ProdutoSection(), PedidoSection()],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    int index, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : null),
      title: Text(title, style: TextStyle(color: isLogout ? Colors.red : null)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
