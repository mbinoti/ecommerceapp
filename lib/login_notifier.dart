import 'package:ecommerceapp/login_repository.dart';
import 'package:flutter/material.dart';

import 'login_state.dart';

/// Notificador para gerenciar o estado do login e registro.
class LoginNotifier extends ValueNotifier<LoginState> {
  final LoginRepository loginRepository;
  String errorMessage = '';

  /// Construtor para a classe LoginNotifier.
  ///
  /// [loginRepository] é uma instância do LoginRepository para realizar
  /// operações de autenticação.
  LoginNotifier({required this.loginRepository}) : super(LoginState());

  /// Realiza o login de um usuário.
  ///
  /// Atualiza o estado do notificador conforme necessário durante o
  /// processo de login.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      value = LoginState(loading: true);
      final loggedIn = await loginRepository.signInWithEmailAndPassword(
        email,
        password,
      );
      value = LoginState(loading: false, loggedIn: loggedIn);
    } catch (e) {
      value = LoginState(loading: false, error: e.toString());
      // errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Registra um novo usuário.
  ///
  /// Atualiza o estado do notificador conforme necessário durante
  /// o processo de registro.
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      value = LoginState(loading: true);
      final signedUp =
          await loginRepository.createUserWithEmailAndPassword(email, password);
      value = LoginState(loading: false, loggedIn: signedUp);
    } catch (e) {
      value = LoginState(loading: false, error: e.toString());
      notifyListeners();
    }
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Your email address appears to be malformed.";
      case "wrong-password":
        return "Your password is wrong.";
      case "user-not-found":
        return "User with this email doesn't exist.";
      case "user-disabled":
        return "User with this email has been disabled.";
      case "too-many-requests":
        return "Too many requests. Try again later.";
      case "operation-not-allowed":
        return "Signing in with Email and Password is not enabled.";
      default:
        return "An undefined Error happened.";
    }
  }
}
