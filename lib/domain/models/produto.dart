import 'package:comerciou_pdv/domain/models/categoria.dart';
import 'package:comerciou_pdv/domain/models/modelo.dart';

class Produto {
  final String nome;
  final String? foto;
  final String fotoThumbnail;
  final int quantidade;
  final String marca;
  final double valor;
  final String descricao;
  final String codigoReferencia;
  final bool movimentaEstoque;
  final bool possuiVariacao;
  final bool showInMenu;
  final List<Modelo> modelos;
  final int categoriaId;
  final Categoria? categoria;
  final List<dynamic> estoques;
  final List<dynamic> vendaProdutos;
  final String origem;
  final String ncm;
  final String gtinEan;
  final String cest;
  final String unidade;
  final int? idEmpresa;
  final dynamic empresa;
  final int id;
  final DateTime createdDate;
  final DateTime updatedDate;

  Produto({
    required this.nome,
    required this.foto,
    required this.fotoThumbnail,
    required this.quantidade,
    required this.marca,
    required this.valor,
    required this.descricao,
    required this.codigoReferencia,
    required this.movimentaEstoque,
    required this.possuiVariacao,
    required this.showInMenu,
    required this.modelos,
    required this.categoriaId,
    this.categoria,
    required this.estoques,
    required this.vendaProdutos,
    required this.origem,
    required this.ncm,
    required this.gtinEan,
    required this.cest,
    required this.unidade,
    this.idEmpresa,
    this.empresa,
    required this.id,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nome: json['nome'],
      foto: json['foto'],
      fotoThumbnail: json['fotoThumbnail'],
      quantidade: json['quantidade'],
      marca: json['marca'],
      valor: (json['valor'] as num).toDouble(),
      descricao: json['descricao'],
      codigoReferencia: json['codigoReferencia'],
      movimentaEstoque: json['movimentaEstoque'],
      possuiVariacao: json['possuiVariacao'],
      showInMenu: json['showInMenu'],
      modelos:
          (json['modelos'] as List).map((e) => Modelo.fromJson(e)).toList(),
      categoriaId: json['categoriaId'],
      categoria:
          json['categoria'] != null
              ? Categoria.fromJson(json['categoria'])
              : null,
      estoques: json['estoques'] ?? [],
      vendaProdutos: json['vendaProdutos'] ?? [],
      origem: json['origem'],
      ncm: json['ncm'],
      gtinEan: json['gtinEan'],
      cest: json['cest'],
      unidade: json['unidade'],
      idEmpresa: json['idEmpresa'],
      empresa: json['empresa'],
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'foto': foto,
      'fotoThumbnail': fotoThumbnail,
      'quantidade': quantidade,
      'marca': marca,
      'valor': valor,
      'descricao': descricao,
      'codigoReferencia': codigoReferencia,
      'movimentaEstoque': movimentaEstoque,
      'possuiVariacao': possuiVariacao,
      'showInMenu': showInMenu,
      'modelos': modelos.map((e) => e.toJson()).toList(),
      'categoriaId': categoriaId,
      'categoria': categoria?.toJson(),
      'estoques': estoques,
      'vendaProdutos': vendaProdutos,
      'origem': origem,
      'ncm': ncm,
      'gtinEan': gtinEan,
      'cest': cest,
      'unidade': unidade,
      'idEmpresa': idEmpresa,
      'empresa': empresa,
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
