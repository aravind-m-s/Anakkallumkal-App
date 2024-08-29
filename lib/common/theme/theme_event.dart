part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeEvent extends ThemeEvent {
  final bool isDarkMode;

  const SwitchThemeEvent({required this.isDarkMode});
}

class GetThemeEvent extends ThemeEvent {}
