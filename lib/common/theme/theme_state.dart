part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

class SwitchThemeState extends ThemeState {
  final bool isDarkMode;

  const SwitchThemeState({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
