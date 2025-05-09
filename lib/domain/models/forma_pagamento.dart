class FormaPagamento {
  int id;
  String nome;

  FormaPagamento({required this.id, required this.nome});

  factory FormaPagamento.fromJson(Map<String, dynamic> json) {
    return FormaPagamento(id: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome};
  }
}
