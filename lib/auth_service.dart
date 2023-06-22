import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null ? 'Login bem sucedido' : 'Usuário não encontrado';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "O email fornecido é inválido.";
        case "wrong-password":
          return "A senha fornecida está incorreta.";
        case "user-not-found":
          return "Não há usuário correspondente ao email fornecido.";
        case "user-disabled":
          return "Este usuário foi desabilitado.";
        case "too-many-requests":
          return "Muitas tentativas de login. Por favor, tente mais tarde.";
        case "operation-not-allowed":
          return "Login com email e senha não habilitado.";
        default:
          return "Ocorreu um erro desconhecido.";
      }
    }
  }

  // Método de criação de usuário
  Future<String> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user != null
          ? 'Usuário criado com sucesso'
          : 'Falha ao criar usuário';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O email fornecido já está em uso por outro usuário.";
        case "invalid-email":
          return "O email fornecido é inválido.";
        case "operation-not-allowed":
          return "Criação de usuário com email e senha não habilitada.";
        case "weak-password":
          return "A senha fornecida é muito fraca.";
        default:
          return "Ocorreu um erro desconhecido.";
      }
    }
  }
}
