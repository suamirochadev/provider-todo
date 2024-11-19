import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/database/sqlite_connection_factory.dart';
import 'package:provider_todo/app/repositories/user/user_repository.dart';
import 'package:provider_todo/app/repositories/user/user_repository_impl.dart';
import 'package:provider_todo/app/services/app_widget.dart';
import 'package:provider_todo/app/services/user/user_service.dart';
import 'package:provider_todo/app/services/user/user_service_impl.dart';
import 'package:provider_todo/app/core/auth/my_auth_provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(
            userRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<MyAuthProvider>(
          create: (context) => MyAuthProvider(
            firebaseAuth: context.read(),
            userService: context.read(),
          )
          ..loadListener(),
          lazy: false,
        )
      ],
      child: const AppWidget(),
    );
  }
}
