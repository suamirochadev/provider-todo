import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.of(context).pushNamed('/login'),
          child: const Text('/Login'),
        ),
      ),
    );
  }
}
