import 'package:flutter/material.dart';
import 'package:provider_todo/app/core/ui/theme_extensions.dart';
import 'package:provider_todo/app/core/widget/todo_list_field.dart';
import 'package:provider_todo/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // não ter um botão padrão para voltar
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: ClipOval(
            //deixa oval
            child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.arrow_back_ios_new_outlined,
                    size: 20, color: context.primaryColor)),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              // redimensiona o conteudo conforme as medidas do pai
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              child: Column(
                children: [
                  TodoListField(
                    label: 'Email',
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Senha',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    label: 'Confirmar Senha',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
