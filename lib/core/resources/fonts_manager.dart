/// Design font sizes. Never add `.sp`: text is scaled once in `main.dart`
/// through `TextScaler.linear(1.sp)`.
class FontSize {
  const FontSize._();

  static const double s12_5 = 12.5;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s50 = 50.0;
}
