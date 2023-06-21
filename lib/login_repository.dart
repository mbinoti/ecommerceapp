import 'package:firebase_auth/firebase_auth.dart';

/// Repositório para lidar com operações de login e registro.
class LoginRepository {
  FirebaseAuth firebaseAuth;

  /// Construtor para a classe LoginRepository.
  ///
  /// [firebaseAuth] é uma instância de FirebaseAuth, permitindo realizar operações de autenticação.
  LoginRepository({required this.firebaseAuth});

  /// Autentica um usuário com o Firebase usando email e senha.
  ///
  /// Retorna `true` se o login for bem-sucedido, `false` caso contrário.
  Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Registra um novo usuário no Firebase usando email e senha.
  ///
  /// Retorna `true` se o registro for bem-sucedido, `false` caso contrário.
  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
