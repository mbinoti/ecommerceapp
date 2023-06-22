import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_notifier.dart';
import 'login_state.dart';

class RegisterPage extends StatelessWidget {
  // final LoginNotifier loginNotifier;
  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<LoginState> loginState =
      ValueNotifier<LoginState>(LoginState());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                String result = await authService.signUp(
                    emailController.text, passwordController.text);
                loginState.value.error = result;

                // await loginNotifier.createUserWithEmailAndPassword(
                //   emailController.text,
                //   passwordController.text,
                // );
                // criar um snackbar
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loginState.value.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
