part of 'languages.dart';

class LanguageFa extends Languages {
  @override
  String get appName => "اسپاتیفای";

  // ------------- failure messages
  @override
  String get fetchDataFailureMessage =>
      "ارتباط با سرور برقرار نشد. دوباره تلاش کن";

  @override
  String get noConnectionFailureMessage => "به اینترنت متصل نیستید!";

  @override
  String get errorHasOccurred => "خطایی رخ داده است!";

  @override
  String get tryAgain => "تلاش مجدد";

  @override
  String get tokenExpiredFailureMessage => "نشست شما منقضی شده‌است";

  @override
  String get errorOccurredFailureMessage => "مشکلی پیش آمده‌است";

  @override
  String get accessDeniedFailureMessage => "فیلترشکن خود را خاموش کنید";

  @override
  String get connectionFailureMessage => "";
}
