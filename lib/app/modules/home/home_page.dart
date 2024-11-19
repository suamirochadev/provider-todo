import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/auth/my_auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(onPressed: () {
          context.read<MyAuthProvider>().logout();
        }, child: const Text('logout')),
      ),
    );
  }
}
