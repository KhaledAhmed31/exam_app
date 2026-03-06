sealed class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizationLoadedState extends LocalizationState {
  final String langCode;
  LocalizationLoadedState(this.langCode);
}
