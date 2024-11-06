import 'package:flutter/material.dart';
import 'package:provider_todo/app/exception/auth.exception.dart';
import 'package:provider_todo/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  void registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();

      final user = await _userService.register(email, password);
      if (user != null) {
        // sucess
        success = true;
      } else {
        // erro
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message; 
    } finally { // finally é sempre chamado independente de erro ou não
      notifyListeners();
    }
  }
}
