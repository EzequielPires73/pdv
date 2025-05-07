import 'package:comerciou_pdv/domain/models/item_pedido.dart';

class Pedido {
  DateTime data;
  String? desconto;
  String? descricao;
  String? frete;
  int? idClient;
  int? idFormaPagamento;
  int? idUser;
  int? tipo;
  double valorTotal;
  List<ItemPedido>? vendaProdutos;

  Pedido({
    required this.data,
    this.desconto,
    this.descricao,
    this.frete,
    this.idClient,
    this.idFormaPagamento,
    this.idUser,
    this.tipo,
    this.valorTotal = 0.0,
    this.vendaProdutos,
  });
}
