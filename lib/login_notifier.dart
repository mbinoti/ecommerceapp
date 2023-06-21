import 'package:ecommerceapp/login_repository.dart';
import 'package:flutter/material.dart';

/// Notificador para gerenciar o estado do login e registro.
class LoginNotifier extends ValueNotifier<LoginState> {
  final LoginRepository loginRepository;

  /// Construtor para a classe LoginNotifier.
  ///
  /// [loginRepository] é uma instância do LoginRepository para realizar
  /// operações de autenticação.
  LoginNotifier({required this.loginRepository}) : super(LoginState());

  /// Realiza o login de um usuário.
  ///
  /// Atualiza o estado do notificador conforme necessário durante o
  /// processo de login.
  Future login(String email, String password) async {
    try {
      value = LoginState(loading: true);
      final loggedIn =
          await loginRepository.signInWithEmailAndPassword(email, password);
      value = LoginState(loading: false, loggedIn: loggedIn);
    } catch (e) {
      value = LoginState(loading: false, error: e.toString());
    }
  }

  /// Registra um novo usuário.
  ///
  /// Atualiza o estado do notificador conforme necessário durante
  /// o processo de registro.
  Future signUp(String email, String password) async {
    try {
      value = LoginState(loading: true);
      final signedUp =
          await loginRepository.createUserWithEmailAndPassword(email, password);
      value = LoginState(loading: false, loggedIn: signedUp);
    } catch (e) {
      value = LoginState(loading: false, error: e.toString());
    }
  }
}

/// Representa o estado do login e registro.
class LoginState {
  final bool
      loading; // Representa se uma operação de login/registro está em andamento.
  final String error; // Representa qualquer erro que possa ter ocorrido durante
  //o login/registro.
  final bool loggedIn; // Representa se o usuário está logado.

  /// Construtor para a classe LoginState.
  LoginState({this.loading = false, this.error = '', this.loggedIn = false});
}
