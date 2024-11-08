import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/modules/todo_module.dart';
import 'package:provider_todo/app/modules/auth/login/login_controller.dart';
import 'package:provider_todo/app/modules/auth/login/login_page.dart';
import 'package:provider_todo/app/modules/auth/register/register_controller.dart';
import 'package:provider_todo/app/modules/auth/register/register_page.dart';

class AuthModule extends TodoModule{
  AuthModule() : super(
    routers: {
      '/login': (c) => const LoginPage(),
      '/register': (c) => const RegisterPage(),
    },
    bindings: [
      ChangeNotifierProvider(create: (context) => LoginController(userService: context.read())),
      ChangeNotifierProvider(create: (context) => RegisterController(userService: context.read())),
    ],
    );
  
 }