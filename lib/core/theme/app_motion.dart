/// App motion system with standardized animation durations and curves.
/// Follows the design system specifications for consistent animations.
import 'package:flutter/animation.dart';

class AppMotion {
  // Durations (in milliseconds)
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration enter = Duration(milliseconds: 225);
  static const Duration exit = Duration(milliseconds: 195);

  // Curves
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve standardCurve = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
}
