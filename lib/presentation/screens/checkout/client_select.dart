import 'package:comerciou_pdv/domain/models/cliente.dart';
import 'package:comerciou_pdv/injections.dart';
import 'package:comerciou_pdv/presentation/view_models/clients_view_model.dart';
import 'package:flutter/material.dart';

class ClientSelect extends StatelessWidget {
  final ClientsViewModel clientsViewModel = injec();
  final Function(Cliente client) onChange;
  ClientSelect({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: clientsViewModel,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Text('Cliente', style: TextStyle(fontWeight: FontWeight.w600)),
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
              barHintText: 'Selecionar cliente',
              suggestionsBuilder: (context, controller) async {
                if (controller.text.isNotEmpty && controller.text.length > 2) {
                  await clientsViewModel.getByName.execute(controller.text);
                }

                if (clientsViewModel.getByName.running) {
                  return [const Center(child: CircularProgressIndicator())];
                }

                final clientes = clientsViewModel.items ?? [];

                if (clientes.isEmpty) {
                  return [
                    const ListTile(title: Text('Nenhum cliente encontrado')),
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
