import 'package:provider_todo/app/core/notifier/default_change_notifier.dart';
import 'package:provider_todo/app/exception/auth.exception.dart';
import 'package:provider_todo/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        setSuccess('Logando..');
        success();
      } else {
        setError('Usuário ou senha inválidos. Por favor, tente novamente');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
