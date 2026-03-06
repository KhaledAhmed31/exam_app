class LocalizationEvents {}

class GetLocalizationEvent extends LocalizationEvents {}

class ChangeLocalizationEvent extends LocalizationEvents {
  final String langCode;
  ChangeLocalizationEvent(this.langCode);
}
