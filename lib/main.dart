import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_repository.dart';
import 'login_notifier.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository =
      LoginRepository(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
          loginNotifier: LoginNotifier(loginRepository: loginRepository)),
      routes: {
        '/register': (_) => RegisterPage(
            loginNotifier: LoginNotifier(loginRepository: loginRepository)),
      },
    );
  }
}
