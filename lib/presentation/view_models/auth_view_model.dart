import 'package:comerciou_pdv/domain/models/user.dart';
import 'package:comerciou_pdv/domain/repositories/auth_repository.dart';
import 'package:comerciou_pdv/utils/command.dart';
import 'package:comerciou_pdv/utils/result.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;
  late final Command1<void, dynamic> signin;
  late final Command0 load;
  late final Command0 signout;

  AuthViewModel({required this.repository}) {
    signin = Command1(_signin);
    load = Command0(_load);
    signout = Command0(_signout);
  }

  User? user;
  String? errorMsg;
  String? type;

  VoidCallback? onSuccess;

  Future<Result> _load() async {
    try {
      final result = await repository.load();
      switch (result) {
        case Ok():
          user = result.value['user'];
          errorMsg = null;
          onSuccess?.call();
          return Result.ok(result.value);
        case Error():
          errorMsg = 'Usuário não está logado..';
          return Result.error(Exception('Usuário não está logado.'));
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<dynamic>> _signin(dynamic data) async {
    try {
      final result = await repository.signin(data['email'], data['password']);

      switch (result) {
        case Ok():
          user = result.value['user'];
          errorMsg = null;
          onSuccess?.call();
          return Result.ok(result.value);
        case Error():
          errorMsg = 'Credenciais inválidas.';
          return Result.error(Exception('Credenciais inválidas.'));
      }
    } finally {
      notifyListeners();
      await load.execute();
    }
  }

  Future<Result<bool>> _signout() async {
    try {
      await repository.signout();
      return Result.ok(true);
    } finally {
      notifyListeners();
      await load.execute();
    }
  }
}
