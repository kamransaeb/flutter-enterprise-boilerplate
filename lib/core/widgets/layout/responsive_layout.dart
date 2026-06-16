import 'package:flutter/material.dart';

enum ScreenSize {
  small,    // < 600px
  medium,   // 600px - 900px
  large,    // > 900px
}

class ResponsiveLayout extends StatelessWidget {
  final Widget smallScreen;
  final Widget mediumScreen;
  final Widget largeScreen;
  final Widget? fallbackScreen;

  const ResponsiveLayout({
    super.key,
    required this.smallScreen,
    required this.mediumScreen,
    required this.largeScreen,
    this.fallbackScreen,
  });

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      return ScreenSize.small;
    } else if (width < 900) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }

  static bool isSmallScreen(BuildContext context) {
    return getScreenSize(context) == ScreenSize.small;
  }

  static bool isMediumScreen(BuildContext context) {
    return getScreenSize(context) == ScreenSize.medium;
  }

  static bool isLargeScreen(BuildContext context) {
    return getScreenSize(context) == ScreenSize.large;
  }

  static bool isMobile(BuildContext context) {
    return isSmallScreen(context);
  }

  static bool isTablet(BuildContext context) {
    return isMediumScreen(context);
  }

  static bool isDesktop(BuildContext context) {
    return isLargeScreen(context);
  }

  static double responsiveValue(
    BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.small:
        return small;
      case ScreenSize.medium:
        return medium;
      case ScreenSize.large:
        return large;
    }
  }

  static EdgeInsetsGeometry responsivePadding(
    BuildContext context, {
    EdgeInsetsGeometry small = EdgeInsets.zero,
    EdgeInsetsGeometry? medium,
    EdgeInsetsGeometry? large,
  }) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.small:
        return small;
      case ScreenSize.medium:
        return medium ?? small * 1.5;
      case ScreenSize.large:
        return large ?? small * 2;
    }
  }

  static double responsiveFontSize(
    BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    return responsiveValue(
      context,
      small: small,
      medium: medium,
      large: large,
    );
  }

  static int responsiveGridCount(
    BuildContext context, {
    int small = 1,
    int medium = 2,
    int large = 4,
  }) {
    return responsiveValue(
      context,
      small: small.toDouble(),
      medium: medium.toDouble(),
      large: large.toDouble(),
    ).toInt();
  }

  static double responsiveImageSize(
    BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    return responsiveValue(
      context,
      small: small,
      medium: medium,
      large: large,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.small:
        return smallScreen;
      case ScreenSize.medium:
        return mediumScreen;
      case ScreenSize.large:
        return largeScreen;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    ScreenSize screenSize,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ResponsiveLayout.getScreenSize(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);
    
    return builder(context, screenSize, isMobile, isTablet, isDesktop);
  }
}

class AdaptivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry small;
  final EdgeInsetsGeometry? medium;
  final EdgeInsetsGeometry? large;
  final bool verticalOnly;
  final bool horizontalOnly;

  const AdaptivePadding({
    super.key,
    required this.child,
    this.small = const EdgeInsets.all(16),
    this.medium,
    this.large,
    this.verticalOnly = false,
    this.horizontalOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveLayout.responsivePadding(
      context,
      small: _getEffectivePadding(small),
      medium: medium != null ? _getEffectivePadding(medium!) : null,
      large: large != null ? _getEffectivePadding(large!) : null,
    );
    
    return Padding(
      padding: padding,
      child: child,
    );
  }

  EdgeInsetsGeometry _getEffectivePadding(EdgeInsetsGeometry base) {
    if (verticalOnly) {
      return EdgeInsets.symmetric(
        vertical: base.vertical,
      );
    } else if (horizontalOnly) {
      return EdgeInsets.symmetric(
        horizontal: base.horizontal,
      );
    }
    return base;
  }
}

class AdaptiveSpacer extends StatelessWidget {
  final double small;
  final double? medium;
  final double? large;
  final bool vertical;
  final bool horizontal;

  const AdaptiveSpacer({
    super.key,
    this.small = 16,
    this.medium,
    this.large,
    this.vertical = true,
    this.horizontal = false,
  }) : assert(vertical || horizontal, 'Must be either vertical or horizontal');

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveLayout.responsiveValue(
      context,
      small: small,
      medium: medium ?? small * 1.5,
      large: large ?? small * 2,
    );
    
    if (vertical && horizontal) {
      return SizedBox(width: size, height: size);
    } else if (vertical) {
      return SizedBox(height: size);
    } else {
      return SizedBox(width: size);
    }
  }
}

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? smallStyle;
  final TextStyle? mediumStyle;
  final TextStyle? largeStyle;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.smallStyle,
    this.mediumStyle,
    this.largeStyle,
    this.align,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? TextStyle();
    final screenSize = ResponsiveLayout.getScreenSize(context);
    
    TextStyle? sizeStyle;
    switch (screenSize) {
      case ScreenSize.small:
        sizeStyle = smallStyle;
        break;
      case ScreenSize.medium:
        sizeStyle = mediumStyle;
        break;
      case ScreenSize.large:
        sizeStyle = largeStyle;
        break;
    }
    
    return Text(
      text,
      style: baseStyle.merge(sizeStyle),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

class AdaptiveIcon extends StatelessWidget {
  final IconData icon;
  final double smallSize;
  final double? mediumSize;
  final double? largeSize;
  final Color? color;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const AdaptiveIcon(
    this.icon, {
    super.key,
    this.smallSize = 24,
    this.mediumSize,
    this.largeSize,
    this.color,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveLayout.responsiveValue(
      context,
      small: smallSize,
      medium: mediumSize ?? smallSize * 1.2,
      large: largeSize ?? smallSize * 1.5,
    );
    
    return Icon(
      icon,
      size: size,
      color: color,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

class AdaptiveGridView extends StatelessWidget {
  final int smallCrossAxisCount;
  final int? mediumCrossAxisCount;
  final int? largeCrossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;

  const AdaptiveGridView({
    super.key,
    this.smallCrossAxisCount = 1,
    this.mediumCrossAxisCount,
    this.largeCrossAxisCount,
    this.childAspectRatio = 1.0,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    required this.children,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveLayout.responsiveGridCount(
      context,
      small: smallCrossAxisCount,
      medium: mediumCrossAxisCount ?? smallCrossAxisCount * 2,
      large: largeCrossAxisCount ?? smallCrossAxisCount * 4,
    );
    
    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}