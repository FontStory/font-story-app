part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final Gradient gradient;
  final int themeIndex;
  final String? fontFamily;

  const ThemeState({
    required this.themeData,
    required this.gradient,
    required this.themeIndex,
    this.fontFamily,
  });

  @override
  List<Object?> get props => [themeData, gradient, themeIndex, fontFamily];
}