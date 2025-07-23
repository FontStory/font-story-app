import 'package:flutter/widgets.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  bool get canPop => Navigator.canPop(this);

  void pop<T extends Object?>([T? result]) {
    navigator.pop<T>(result);
  }

  void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }
}
