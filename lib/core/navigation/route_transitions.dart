import 'package:flutter/material.dart';

/// Custom route transitions
class RouteTransitions {
  /// Slide from right
  static Widget slideFromRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Slide from left
  static Widget slideFromLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    /// Tween<T> short for in-between define how to interpolate between two values of type T
    /// Tween.lerp(double t) returns a value between begin and end based on the value of t
    /// t = 0.0 -> begin
    /// t = 1.0 -> end
    /// t = 0.5 -> middle of the tween
    /// t = 0.25 -> 25% of the tween
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  static Widget slideFromBottom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Fade transition
  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  /// Scale transition (zoom in)
  static Widget scaleIn(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack)),
      child: child,
    );
  }

  /// Scale transition (zoom out)
  static Widget scaleOut(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: 0.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInBack)),
      child: child,
    );
  }

  /// Size transition
  static Widget size(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  /// Combined fade and slide transition
  static Widget fadeAndSlide(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var slideTween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: curve));
    var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
    );
  }

  /// Secondary Animation used for the second screen in the stack
  static Widget slideWithBackgroundFade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const beginOffset = Offset(1.0, 0.0);
    const endOffset = Offset.zero;
    final slideTween = Tween(
      begin: beginOffset,
      end: endOffset,
    ).chain(CurveTween(curve: Curves.easeInOutCubic));

    /// Slide animation for the new screen
    final slideAnimation = animation.drive(slideTween);

    /// Background fade animation for the old second
    final backgroundFade = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(secondaryAnimation);
    return FadeTransition(
      opacity: backgroundFade,
      child: SlideTransition(position: slideAnimation, child: child),
    );
  }

  // Example usage:
  // PageRouteBuilder(
  //   pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
  //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //     return RouteTransitions.slideFromRight(
  //       context,
  //       animation,
  //       secondaryAnimation,
  //       child,
  //     );
  //   },
  // );
}
