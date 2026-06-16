class ResetPasswordParams {
  final String token;
  final String newPassword;

  ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });
}