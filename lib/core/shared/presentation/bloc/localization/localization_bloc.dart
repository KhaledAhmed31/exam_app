import 'package:exam_app/core/shared/presentation/bloc/localization/localization_events.dart';
import 'package:exam_app/core/shared/presentation/bloc/localization/localization_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class LocalizationBloc extends Bloc<LocalizationEvents, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial()) {
    on<GetLocalizationEvent>(_getLanguage);
    on<ChangeLocalizationEvent>(_changeLanguage);
    add(GetLocalizationEvent());
  }

  void _getLanguage(GetLocalizationEvent event, Emitter emit) async {
    emit(LocalizationLoadedState("en"));
  }

  void _changeLanguage(ChangeLocalizationEvent event, Emitter emit) async {
    emit(LocalizationLoadedState(event.langCode));
  }
}
