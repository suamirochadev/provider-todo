import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/app/core/notifier/default_listener_notifier.dart';
import 'package:provider_todo/app/core/ui/theme_extensions.dart';
import 'package:provider_todo/app/core/widget/todo_list_field.dart';
import 'package:provider_todo/app/core/widget/todo_list_logo.dart';
import 'package:provider_todo/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    context.read<RegisterController>().removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose(); // é importante fazer o dispose antes do pop
        //para evitar qualquer tipo de problema.
        Navigator.of(context).pop(); // retorna para a tela anterior após sucesso.
      },

      // isso é opcional mas eu vou deixar
      errorCallback: (notifier, listenerInstance) {
        // ignore: avoid_print
        print('Ocorreu um erro, por favor investigue: register controller');
      }
    );
    // context.read<RegisterController>().addListener(() {
    //   final controller = context.read<RegisterController>();
    //   var success = controller.success;
    //   var error = controller.error;
    //   if (success) {
    //     Navigator.of(context).pop();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Sucesso, sua conta já foi criada. Entre com o login.'),
    //         backgroundColor: Colors.green,
    //       ),
    //     );
    //   } else if (error != null && error.isNotEmpty) {

    //   }
    // });
  }

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
          SizedBox(
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
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'Email',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório.'),
                      Validatorless.email('Email inválido.')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória.'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres.')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    label: 'Confirmar Senha',
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória.'),
                      Validatorless.compare(_passwordEC,
                          'As senhas não são iguai, tente novamente.')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
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
