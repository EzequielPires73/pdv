import 'package:comerciou_pdv/domain/repositories/core/repository.dart';
import 'package:comerciou_pdv/utils/command.dart';
import 'package:comerciou_pdv/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseCrudViewModel<T> extends ChangeNotifier {
  BaseCrudViewModel({required this.repository}) {
    load = Command0(_load)..execute();
    create = Command1(_create);
    update = Command1(_update);
    delete = Command1(_delete);
    getOneById = Command1(_getOneById);
  }

  final IRepository<T> repository;
  List<T>? items;
  T? itemDetails;
  dynamic itemId;

  late Command0 load;
  late Command1<void, T> create;
  late Command1<void, T> update;
  late Command1<void, dynamic> delete;
  late Command1<void, int> getOneById;

  Future<Result> _load() async {
    try {
      final result = await repository.getAll();
      switch (result) {
        case Ok<List<T>>():
          items = result.value;
        case Error<List<T>>():
          items = [];
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _create(T item) async {
    final result = await repository.create(item);
    if (result is Ok) {
      showToast('Item criado com sucesso.');
      await load.execute();
    } else {
      showToast(result.toString(), isError: true);
    }
    notifyListeners();
    return result;
  }

  Future<Result> _update(T item) async {
    final result = await repository.update(item);
    if (result is Ok) {
      showToast('Item atualizado com sucesso.');
      await load.execute();
      if (itemId != null) {
        await this.getOneById.execute(itemId);
      }
    } else {
      showToast(result.toString(), isError: true);
    }
    notifyListeners();
    return result;
  }

  Future<Result> _delete(dynamic item) async {
    final result = await repository.delete(item);
    if (result is Ok) {
      showToast('Item removido com sucesso.');
      await load.execute();
    }
    notifyListeners();
    return result;
  }

  Future<Result> _getOneById(dynamic id) async {
    try {
      itemId = id;
      final result = await repository.getOneById(id);
      switch (result) {
        case Ok<T>():
          itemDetails = result.value;
        case Error<T>():
          itemDetails = null;
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red.shade50 : Colors.green.shade50,
      textColor: isError ? Colors.red : Colors.green,
      fontSize: 12,
    );
  }
}
