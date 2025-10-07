import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'
    show BorderRadius, Border, EdgeInsets, BoxShadow, Color, Offset;

part 'box_decoration_state.dart';

class BoxDecorationCubit extends Cubit<BoxDecorationState> {
  BoxDecorationCubit() : super(const BoxDecorationState());

  void resetFromDecoration({
    BorderRadius? borderRadius,
    Border? border,
    EdgeInsets? padding,
    List<BoxShadow>? shadows,
  }) {
    setDefaultBorderRadius(borderRadius);
    setDefaultBorder(border);
    setDefaultPadding(padding);
    setDefaultShadow(shadows);
  }

  // -------------------------------
  // Radius Methods
  // -------------------------------
  void setDefaultBorderRadius(BorderRadius? borderRadius) {
    if (borderRadius == null) return;

    final tl = borderRadius.topLeft.x;
    final tr = borderRadius.topRight.x;
    final bl = borderRadius.bottomLeft.x;
    final br = borderRadius.bottomRight.x;
    final allEqual = tl == tr && tl == bl && tl == br;

    emit(
      state.copyWith(
        allRadius: allEqual ? tl : state.allRadius,
        topLeftRadius: tl,
        topRightRadius: tr,
        bottomLeftRadius: bl,
        bottomRightRadius: br,
      ),
    );
  }

  void changeAllBorderRadius(double value) => emit(
    state.copyWith(
      allRadius: value,
      topLeftRadius: value,
      topRightRadius: value,
      bottomLeftRadius: value,
      bottomRightRadius: value,
    ),
  );

  void changeTopLeftRadius(double value) =>
      emit(state.copyWith(topLeftRadius: value));
  void changeTopRightRadius(double value) =>
      emit(state.copyWith(topRightRadius: value));
  void changeBottomLeftRadius(double value) =>
      emit(state.copyWith(bottomLeftRadius: value));
  void changeBottomRightRadius(double value) =>
      emit(state.copyWith(bottomRightRadius: value));

  // -------------------------------
  // Border Methods
  // -------------------------------
  void setDefaultBorder(Border? border) {
    if (border == null) return;

    final t = border.top;
    final b = border.bottom;
    final l = border.left;
    final r = border.right;
    final allEqual = t == b && t == l && t == r;

    emit(
      state.copyWith(
        borderColor: t.color,
        allBorderWidth: allEqual ? t.width : state.allBorderWidth,
        topBorderWidth: t.width,
        bottomBorderWidth: b.width,
        leftBorderWidth: l.width,
        rightBorderWidth: r.width,
      ),
    );
  }

  void changeBorderColor(Color? color) =>
      emit(state.copyWith(borderColor: color));

  void changeAllBorderWidth(double value) => emit(
    state.copyWith(
      allBorderWidth: value,
      topBorderWidth: value,
      bottomBorderWidth: value,
      leftBorderWidth: value,
      rightBorderWidth: value,
    ),
  );

  void changeTopBorderWidth(double value) =>
      emit(state.copyWith(topBorderWidth: value));
  void changeBottomBorderWidth(double value) =>
      emit(state.copyWith(bottomBorderWidth: value));
  void changeLeftBorderWidth(double value) =>
      emit(state.copyWith(leftBorderWidth: value));
  void changeRightBorderWidth(double value) =>
      emit(state.copyWith(rightBorderWidth: value));

  // -------------------------------
  // Padding Methods
  // -------------------------------
  void setDefaultPadding(EdgeInsets? padding) {
    if (padding == null) return;

    final t = padding.top;
    final b = padding.bottom;
    final l = padding.left;
    final r = padding.right;
    final allEqual = t == b && t == l && t == r;

    emit(
      state.copyWith(
        allPadding: allEqual ? t : 0.0,
        topPadding: t,
        bottomPadding: b,
        leftPadding: l,
        rightPadding: r,
      ),
    );
  }

  void changeAllPadding(double value) => emit(
    state.copyWith(
      allPadding: value,
      topPadding: value,
      bottomPadding: value,
      leftPadding: value,
      rightPadding: value,
    ),
  );

  void changeTopPadding(double value) =>
      emit(state.copyWith(topPadding: value));
  void changeBottomPadding(double value) =>
      emit(state.copyWith(bottomPadding: value));
  void changeLeftPadding(double value) =>
      emit(state.copyWith(leftPadding: value));
  void changeRightPadding(double value) =>
      emit(state.copyWith(rightPadding: value));

  // -------------------------------
  // Shadow Methods
  // -------------------------------
  void setDefaultShadow(List<BoxShadow>? boxShadows) {
    if (boxShadows == null || boxShadows.isEmpty) return;

    final shadow = boxShadows.first;
    emit(
      state.copyWith(
        shadowColor: shadow.color,
        shadowBlurRadius: shadow.blurRadius,
        shadowSpreadRadius: shadow.spreadRadius,
        shadowOffset: shadow.offset,
      ),
    );
  }

  void changeShadowColor(Color? color) =>
      emit(state.copyWith(shadowColor: color));
  void changeShadowBlurRadius(double value) =>
      emit(state.copyWith(shadowBlurRadius: value));
  void changeShadowSpreadRadius(double value) =>
      emit(state.copyWith(shadowSpreadRadius: value));

  void changeShadowOffset({double? x, double? y}) => emit(
    state.copyWith(
      shadowOffset: Offset(
        x ?? state.shadowOffset?.dx ?? 0,
        y ?? state.shadowOffset?.dy ?? 0,
      ),
    ),
  );
}
