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

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      data: DateTime.parse(json['data']),
      desconto: json['desconto'],
      descricao: json['descricao'],
      frete: json['frete'],
      idClient: json['idClient'],
      idFormaPagamento: json['idFormaPagamento'],
      idUser: json['idUser'],
      tipo: json['tipo'],
      valorTotal: (json['valorTotal'] as num).toDouble(),
      vendaProdutos:
          json['vendaProdutos'] != null
              ? List<ItemPedido>.from(
                json['vendaProdutos'].map((item) => ItemPedido.fromJson(item)),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toIso8601String(),
      'desconto': desconto,
      'descricao': descricao,
      'frete': frete,
      'idClient': idClient,
      'idFormaPagamento': idFormaPagamento,
      'idUser': idUser,
      'tipo': 1,
      'valorTotal': valorTotal,
      'vendaProdutos': vendaProdutos?.map((item) => item.toJson()).toList(),
    };
  }
}
