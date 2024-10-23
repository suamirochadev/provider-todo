import 'package:flutter/material.dart';
import 'package:provider_todo/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
        
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
    super.didChangeAppLifecycleState(state);
  }
}
