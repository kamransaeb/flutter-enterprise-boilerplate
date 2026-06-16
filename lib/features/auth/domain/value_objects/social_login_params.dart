enum SocialProvider { google, apple, facebook }

class SocialLoginParams {
  final SocialProvider provider;

  SocialLoginParams({required this.provider});
}