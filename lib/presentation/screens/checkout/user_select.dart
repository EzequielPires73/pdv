import 'package:comerciou_pdv/domain/models/user.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/users_view_model.dart';
import 'package:flutter/material.dart';

class UserSelect extends StatelessWidget {
  final UsersViewModel usersViewModel = injec();
  final Function(User client) onChange;
  UserSelect({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: usersViewModel,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Text('Vendedor', style: TextStyle(fontWeight: FontWeight.w600)),
            SearchAnchor.bar(
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
              barHintText: 'Selecionar usuário',
              suggestionsBuilder: (context, controller) async {
                if (controller.text.isNotEmpty && controller.text.length > 2) {
                  await usersViewModel.getByName.execute(controller.text);
                }

                if (usersViewModel.getByName.running) {
                  return [const Center(child: CircularProgressIndicator())];
                }

                final clientes = usersViewModel.items ?? [];

                if (clientes.isEmpty) {
                  return [
                    const ListTile(title: Text('Nenhum usuário encontrado')),
                  ];
                }

                return clientes.map<Widget>((item) {
                  return ListTile(
                    title: Text(item.name),
                    onTap: () {
                      controller.text = item.name;
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
