import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'flex_settings_state.dart';

class FlexSettingsCubit extends Cubit<FlexSettingsState> {
  FlexSettingsCubit() : super(const FlexSettingsState());

  set mainAxisAlignment(MainAxisAlignment value) {
    emit(state.copyWith(mainAxisAlignment: value));
  }

  set mainAxisSize(MainAxisSize value) {
    emit(state.copyWith(mainAxisSize: value));
  }

  set crossAxisAlignment(CrossAxisAlignment value) {
    emit(state.copyWith(crossAxisAlignment: value));
  }

  set verticalDirection(VerticalDirection value) {
    emit(state.copyWith(verticalDirection: value));
  }
}
