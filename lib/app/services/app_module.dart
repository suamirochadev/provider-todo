import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/database/sqlite_connection_factory.dart';
import 'package:provider_todo/app/services/app_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        )
      ],
      child: const AppWidget(),
    );
  }
}
