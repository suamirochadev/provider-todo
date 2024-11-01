import 'package:flutter/material.dart';
import 'package:provider_todo/app/core/database/sqlite_adm_connection.dart';
import 'package:provider_todo/app/core/ui/todo_list_config.dart';
import 'package:provider_todo/app/modules/auth/auth_module.dart';
import 'package:provider_todo/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    // Quando o build dessa page terminar, o widgetbinding fará algo
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Provider',
      initialRoute: '/login',
      theme: TodoListConfig.theme,
      routes: {
        ...AuthModule().routers
      },
      home: const SplashPage(),
    );
  }
}
