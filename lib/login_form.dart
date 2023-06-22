import 'package:ecommerceapp/auth_service.dart';
import 'package:ecommerceapp/login_notifier.dart';
import 'package:flutter/material.dart';

import 'login_state.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  // criar um valueNotifier para LoginState
  final ValueNotifier<LoginState> loginState =
      ValueNotifier<LoginState>(LoginState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              String result = await authService.signIn(
                  emailController.text, passwordController.text);
              loginState.value.error = result;

              //
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loginState.value.error),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    loginState.dispose();
    super.dispose();
  }
}
