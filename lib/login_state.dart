/// Representa o estado do login e registro.
class LoginState {
  // Representa se uma operação de login/registro está em andamento.
  bool loading;

  // Representa qualquer erro que possa ter ocorrido durante o login/registro.
  String error;

  // Representa se o usuário está logado.
  bool loggedIn;

  /// Construtor para a classe LoginState.
  LoginState({this.loading = false, this.error = '', this.loggedIn = false});
}
