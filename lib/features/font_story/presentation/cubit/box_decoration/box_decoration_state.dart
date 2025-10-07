part of 'box_decoration_cubit.dart';

class BoxDecorationState extends Equatable {
  // Radius
  final double? allRadius,
      topLeftRadius,
      topRightRadius,
      bottomLeftRadius,
      bottomRightRadius;

  // Border
  final Color? borderColor;
  final double? allBorderWidth,
      topBorderWidth,
      bottomBorderWidth,
      leftBorderWidth,
      rightBorderWidth;

  // Paddings
  final double? allPadding,
      topPadding,
      bottomPadding,
      leftPadding,
      rightPadding;

  // Shadow
  final Color? shadowColor;
  final double? shadowBlurRadius, shadowSpreadRadius;
  final Offset? shadowOffset;

  const BoxDecorationState({
    this.allRadius,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.allBorderWidth,
    this.topBorderWidth,
    this.bottomBorderWidth,
    this.leftBorderWidth,
    this.rightBorderWidth,
    this.borderColor,
    this.allPadding,
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.shadowOffset,
  });

  BoxDecorationState copyWith({
    double? allRadius,
    double? topLeftRadius,
    double? topRightRadius,
    double? bottomLeftRadius,
    double? bottomRightRadius,
    double? allBorderWidth,
    double? topBorderWidth,
    double? bottomBorderWidth,
    double? leftBorderWidth,
    double? rightBorderWidth,
    Color? borderColor,
    double? allPadding,
    double? topPadding,
    double? bottomPadding,
    double? leftPadding,
    double? rightPadding,
    Color? shadowColor,
    double? shadowBlurRadius,
    double? shadowSpreadRadius,
    Offset? shadowOffset,
  }) {
    return BoxDecorationState(
      allRadius: allRadius ?? this.allRadius,
      topLeftRadius: topLeftRadius ?? this.topLeftRadius,
      topRightRadius: topRightRadius ?? this.topRightRadius,
      bottomLeftRadius: bottomLeftRadius ?? this.bottomLeftRadius,
      bottomRightRadius: bottomRightRadius ?? this.bottomRightRadius,
      allBorderWidth: allBorderWidth ?? this.allBorderWidth,
      topBorderWidth: topBorderWidth ?? this.topBorderWidth,
      bottomBorderWidth: bottomBorderWidth ?? this.bottomBorderWidth,
      leftBorderWidth: leftBorderWidth ?? this.leftBorderWidth,
      rightBorderWidth: rightBorderWidth ?? this.rightBorderWidth,
      borderColor: borderColor ?? this.borderColor,
      allPadding: allPadding ?? this.allPadding,
      topPadding: topPadding ?? this.topPadding,
      bottomPadding: bottomPadding ?? this.bottomPadding,
      leftPadding: leftPadding ?? this.leftPadding,
      rightPadding: rightPadding ?? this.rightPadding,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowSpreadRadius: shadowSpreadRadius ?? this.shadowSpreadRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
    );
  }

  @override
  List<Object?> get props => [
    allRadius,
    topLeftRadius,
    topRightRadius,
    bottomLeftRadius,
    bottomRightRadius,
    allBorderWidth,
    topBorderWidth,
    bottomBorderWidth,
    leftBorderWidth,
    rightBorderWidth,
    borderColor,
    allPadding,
    topPadding,
    bottomPadding,
    leftPadding,
    rightPadding,
    shadowColor,
    shadowBlurRadius,
    shadowSpreadRadius,
    shadowOffset,
  ];
}
