import 'package:provider_todo/app/core/notifier/default_change_notifier.dart';
import 'package:provider_todo/app/exception/auth.exception.dart';
import 'package:provider_todo/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null && infoMessage!.isNotEmpty;

  Future<void> googleLogin() async {
    // existe um tratamento de erros aqui para que não tenha um problema de 
    // sobrescrever o cadastro com o google
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

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

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

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

  void forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para o seu email';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      if (e is AuthException) {
        setError(e.message);
      }
      setError('Erro ao enviar email de reset de senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
