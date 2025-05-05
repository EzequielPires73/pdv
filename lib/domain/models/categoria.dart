class Categoria {
  final String nome;
  final List<dynamic> produtos;
  final int idEmpresa;
  final dynamic empresa;
  final int id;
  final DateTime createdDate;
  final DateTime updatedDate;

  Categoria({
    required this.nome,
    required this.produtos,
    required this.idEmpresa,
    this.empresa,
    required this.id,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome: json['nome'],
      produtos: json['produtos'] ?? [],
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
      'produtos': produtos,
      'idEmpresa': idEmpresa,
      'empresa': empresa,
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
