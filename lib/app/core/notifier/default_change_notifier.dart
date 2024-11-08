import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  // Default Change Notifier foi criada para centralizar todos os métodos genéri
  //cos que emitem uma mensagem. Utiliários.
  bool _loading = false;
  String? _error;
  bool _success = false;
  String? _successMessage;

  // encapsulamento: ninguém poderá modificar o loading se não for por dentro
  //dessa classe
  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSuccess => _success;
  String? get successMessage => _successMessage;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = error;
  void setSuccess(String? successMessage) => _successMessage = successMessage;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }
}
