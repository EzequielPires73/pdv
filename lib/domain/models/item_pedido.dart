import 'package:comerciou_pdv/domain/models/modelo.dart';
import 'package:comerciou_pdv/domain/models/produto.dart';

class ItemPedido {
  Produto produto;
  final int idProduto;
  final double precoTotal;
  final double precoUn;
  final int quantidade;
  final int? idModeloProduto;
  Modelo? modelo;

  ItemPedido({
    required this.idProduto,
    required this.precoTotal,
    required this.precoUn,
    required this.quantidade,
    required this.produto,
    this.idModeloProduto,
    this.modelo,
  });

  ItemPedido copyWith({
    Produto? produto,
    int? idProduto,
    double? precoTotal,
    double? precoUn,
    int? quantidade,
    int? idModeloProduto,
    Modelo? modelo,
  }) {
    return ItemPedido(
      idProduto: idProduto ?? this.idProduto,
      precoUn: precoUn ?? this.precoUn,
      produto: produto ?? this.produto,
      modelo: modelo ?? this.modelo,
      idModeloProduto: idModeloProduto ?? this.idModeloProduto,
      quantidade: quantidade ?? this.quantidade,
      precoTotal: precoTotal ?? this.precoTotal,
    );
  }

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      idProduto: json['idProduto'],
      precoTotal: (json['precoTotal'] as num).toDouble(),
      precoUn: (json['precoUn'] as num).toDouble(),
      quantidade: json['quantidade'],
      produto: Produto.fromJson(json['produto']),
      idModeloProduto: json['idModeloProduto'],
      modelo: json['modelo'] != null ? Modelo.fromJson(json['modelo']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProduto': idProduto,
      'precoTotal': precoTotal,
      'precoUn': precoUn,
      'quantidade': quantidade,
      //'produto': produto.toJson(),
      'idModeloProduto': idModeloProduto,
      //'modelo': modelo?.toJson(),
    };
  }
}
