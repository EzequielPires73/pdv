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
      idProduto: this.idProduto,
      precoUn: precoUn ?? this.precoUn,
      produto: this.produto,
      modelo: modelo ?? this.modelo,
      idModeloProduto: idModeloProduto ?? this.idModeloProduto,
      quantidade: quantidade ?? this.quantidade,
      precoTotal: precoTotal ?? this.precoTotal,
    );
  }
}
