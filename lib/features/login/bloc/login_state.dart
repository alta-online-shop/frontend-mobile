class LoginState {
  final String? token;
  final String? error;
  const LoginState({
    required this.token,
    this.error,
  });
}
