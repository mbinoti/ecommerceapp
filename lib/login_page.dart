import 'package:flutter/material.dart';
import 'login_notifier.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  final LoginNotifier loginNotifier;

  LoginPage({required this.loginNotifier});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to login: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await loginNotifier.signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                    ),
                    if (state.error.isNotEmpty) Text(state.error),
                    if (state.loggedIn) const Text('Logged In'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
