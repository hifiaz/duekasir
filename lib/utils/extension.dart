import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isMobile => MediaQuery.of(this).size.width <= 450;
  bool get isTablet => MediaQuery.of(this).size.width >= 451 && MediaQuery.of(this).size.width <= 1200;
}
