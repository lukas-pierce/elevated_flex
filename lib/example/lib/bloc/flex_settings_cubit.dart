import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'flex_settings_state.dart';

class FlexSettingsCubit extends Cubit<FlexSettingsState> {
  FlexSettingsCubit() : super(FlexSettingsInitial());
}
