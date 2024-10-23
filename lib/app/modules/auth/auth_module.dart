import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/modules/todo_module.dart';
import 'package:provider_todo/app/modules/auth/login/login_controller.dart';
import 'package:provider_todo/app/modules/auth/login/login_page.dart';

class AuthModule extends TodoModule{
  AuthModule() : super(
    routers: {
      '/login': (c) => const LoginPage(),
    },
    bindings: [
      ChangeNotifierProvider(create: (_) => LoginController()),
    ],
    );
  
 }