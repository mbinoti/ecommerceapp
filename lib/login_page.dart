import 'package:flutter/material.dart';
import 'login_notifier.dart';

class LoginPage extends StatelessWidget {
  final LoginNotifier loginNotifier;

  LoginPage({required this.loginNotifier});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<LoginState>(
        valueListenable: loginNotifier,
        builder: (context, state, child) {
          if (state.loading) {
            return const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  await loginNotifier.login(
                      emailController.text, passwordController.text);
                },
                child: const Text('Sign In'),
              ),
              if (state.error.isNotEmpty) Text(state.error),
              if (state.loggedIn) const Text('Logged In'),
            ],
          );
        },
      ),
    );
  }
}
