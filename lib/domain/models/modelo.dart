class Modelo {
  final String nome;
  final double valor;
  final int produtoId;
  final dynamic vendaProdutos;
  final int idEmpresa;
  final dynamic empresa;
  final String codigoReferencia;
  final int id;
  final DateTime createdDate;
  final DateTime updatedDate;

  Modelo({
    required this.nome,
    required this.valor,
    required this.produtoId,
    this.vendaProdutos,
    required this.idEmpresa,
    this.empresa,
    required this.codigoReferencia,
    required this.id,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
      nome: json['nome'],
      valor: (json['valor'] as num).toDouble(),
      produtoId: json['produtoId'],
      vendaProdutos: json['vendaProdutos'],
      idEmpresa: json['idEmpresa'],
      empresa: json['empresa'],
      codigoReferencia: json['codigoReferencia'],
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'valor': valor,
      'produtoId': produtoId,
      'vendaProdutos': vendaProdutos,
      'idEmpresa': idEmpresa,
      'empresa': empresa,
      'codigoReferencia': codigoReferencia,
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
