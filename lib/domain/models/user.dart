class User {
  int id;
  String name;
  int? modelId;
  int? codRef;
  int? value;
  bool? isModel;

  User({
    required this.id,
    required this.name,
    this.modelId,
    this.codRef,
    this.value,
    this.isModel,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
