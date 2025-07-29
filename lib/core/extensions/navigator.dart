import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  Future<T?> push<T extends Object?>(String routeName, {Object? arguments}) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigator.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushAndRemoveAll<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigator.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  bool get canPop => Navigator.canPop(this);

  void pop<T extends Object?>([T? result]) {
    if (canPop) {
      navigator.pop<T>(result);
    }
  }

  void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }
}
