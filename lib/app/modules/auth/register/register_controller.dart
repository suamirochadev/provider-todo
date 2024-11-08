import 'package:provider_todo/app/core/notifier/default_change_notifier.dart';
import 'package:provider_todo/app/exception/auth.exception.dart';
import 'package:provider_todo/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userService.register(email, password);
      if (user != null) {
        // sucess
        success();
      } else {
        // erro
        setError('Erro ao registrar o usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      // finally é sempre chamado independente de erro ou não
      notifyListeners();
    }
  }
}
