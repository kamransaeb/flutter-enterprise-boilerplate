// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Flutter Kurumsal Şablon';

  @override
  String get login => 'Giriş Yap';

  @override
  String get email => 'E-posta';

  @override
  String get emailRequired => 'E-posta gereklidir';

  @override
  String get emailInvalid => 'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get password => 'Şifre';

  @override
  String get passwordRequired => 'Şifre gereklidir';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get welcomeBack => 'Tekrar Hoş Geldiniz';

  @override
  String get signInToContinue => 'Devam etmek için giriş yapın';

  @override
  String get dashboard => 'Kontrol Paneli';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get errorOccurred => 'Bir hata oluştu';

  @override
  String get networkErrorMessage =>
      'Ağ hatası. Lütfen bağlantınızı kontrol edin.';

  @override
  String get serverErrorMessage =>
      'Sunucu hatası. Lütfen daha sonra tekrar deneyin.';

  @override
  String get authenticationErrorMessage => 'Lütfen tekrar giriş yapın.';

  @override
  String get authorizationErrorMessage =>
      'Erişim reddedildi. Bu işlemi gerçekleştirmek için yetkiniz yok.';

  @override
  String validationErrorMessage(String message) {
    return 'Doğrulama hatası: $message';
  }

  @override
  String get notFoundErrorMessage => 'Kaynak bulunamadı.';

  @override
  String get cacheErrorMessage => 'Önbellek hatası. Lütfen tekrar deneyin.';

  @override
  String get timeoutErrorMessage =>
      'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';

  @override
  String businessErrorMessage(String message) {
    return '$message';
  }

  @override
  String get unknownErrorMessage => 'Beklenmeyen bir hata oluştu.';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String welcomeUser(String name) {
    return 'Hoş geldin, $name!';
  }

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get resetPassword => 'Şifreyi Sıfırla';

  @override
  String get resetPasswordTitle => 'Şifrenizi Sıfırlayın';

  @override
  String get resetPasswordSubtitle =>
      'E-posta adresinizi girin, size şifre sıfırlama bağlantısı göndereceğiz';

  @override
  String get sendResetLink => 'Sıfırlama Bağlantısı Gönder';

  @override
  String get backToLogin => 'Giriş Sayfasına Dön';
}
