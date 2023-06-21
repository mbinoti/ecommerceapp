import 'package:flutter/material.dart';
import 'login_notifier.dart';

class RegisterPage extends StatelessWidget {
  final LoginNotifier loginNotifier;

  RegisterPage({required this.loginNotifier});

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
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  await loginNotifier.signUp(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: const Text('Sign Up'),
              ),
              if (state.error.isNotEmpty) Text(state.error),
              if (state.loggedIn) Text('Signed Up'),
            ],
          );
        },
      ),
    );
  }
}
