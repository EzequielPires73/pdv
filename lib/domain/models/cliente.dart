class Cliente {
  int id;
  String name;
  int? modelId;
  int? codRef;
  int? value;
  bool? isModel;

  Cliente({
    required this.id,
    required this.name,
    this.modelId,
    this.codRef,
    this.value,
    this.isModel,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      name: json['name'],
      modelId: json['modelId'],
      codRef: json['codRef'],
      value: json['value'],
      isModel: json['isModel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'modelId': modelId,
      'codRef': codRef,
      'value': value,
      'isModel': isModel,
    };
  }
}
