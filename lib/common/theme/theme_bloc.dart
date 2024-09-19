import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<SwitchThemeEvent>(
      (event, emit) => emit(SwitchThemeState(isDarkMode: event.isDarkMode)),
    );
    on<GetThemeEvent>(
      (event, emit) => emit(const SwitchThemeState(isDarkMode: false)),
    );
  }
}
