import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
/// Breakpoints:
/// - Mobile: < 600px
/// - Tablet: 600px - 899px
/// - Desktop: 900px - 1199px
/// - Large Desktop: >= 1200px
class Responsive {
  // Breakpoint constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// Get current screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get current screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  /// Check if screen is tablet
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    final width = screenWidth(context);
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  /// Check if screen is large desktop
  static bool isLargeDesktop(BuildContext context) {
    return screenWidth(context) >= desktopBreakpoint;
  }

  /// Check if screen is mobile or tablet
  static bool isMobileOrTablet(BuildContext context) {
    return screenWidth(context) < tabletBreakpoint;
  }

  /// Check if screen is desktop or larger
  static bool isDesktopOrLarger(BuildContext context) {
    return screenWidth(context) >= tabletBreakpoint;
  }

  /// Get responsive value based on screen size
  /// Returns appropriate value for mobile, tablet, desktop, or large desktop
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final width = screenWidth(context);

    if (width >= desktopBreakpoint) {
      return largeDesktop ?? desktop ?? tablet ?? mobile;
    } else if (width >= tabletBreakpoint) {
      return desktop ?? tablet ?? mobile;
    } else if (width >= mobileBreakpoint) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  /// Get responsive horizontal padding
  static double horizontalPadding(BuildContext context) {
    return value<double>(
      context,
      mobile: 20,
      tablet: 40,
      desktop: 80,
      largeDesktop: 120,
    );
  }

  /// Get responsive section padding
  static EdgeInsets sectionPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding(context),
      vertical: value<double>(
        context,
        mobile: 60,
        tablet: 70,
        desktop: 80,
        largeDesktop: 100,
      ),
    );
  }

  /// Get responsive grid cross axis count
  static int gridColumns(BuildContext context, {int maxColumns = 4}) {
    return value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: maxColumns > 2 ? 3 : 2,
      largeDesktop: maxColumns,
    );
  }

  /// Get responsive font size multiplier
  static double fontScale(BuildContext context) {
    return value<double>(
      context,
      mobile: 0.85,
      tablet: 0.95,
      desktop: 1.0,
      largeDesktop: 1.1,
    );
  }

  /// Get responsive heading font size
  static double headingSize(BuildContext context, {double baseSize = 36}) {
    return baseSize * fontScale(context);
  }

  /// Get responsive body font size
  static double bodySize(BuildContext context, {double baseSize = 16}) {
    return baseSize * fontScale(context);
  }

  /// Get max content width for large screens
  static double maxContentWidth(BuildContext context) {
    return value<double>(
      context,
      mobile: double.infinity,
      tablet: double.infinity,
      desktop: 1100,
      largeDesktop: 1400,
    );
  }

  /// Wrap content with max width constraint for large screens
  static Widget constrainedContent({
    required BuildContext context,
    required Widget child,
    double? maxWidth,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? maxContentWidth(context),
        ),
        child: child,
      ),
    );
  }

  /// Get responsive spacing
  static double spacing(BuildContext context, {double baseSpacing = 16}) {
    return baseSpacing * fontScale(context);
  }

  /// Get responsive card aspect ratio
  static double cardAspectRatio(
    BuildContext context, {
    double mobileRatio = 1.5,
    double tabletRatio = 1.3,
    double desktopRatio = 1.2,
  }) {
    return value<double>(
      context,
      mobile: mobileRatio,
      tablet: tabletRatio,
      desktop: desktopRatio,
      largeDesktop: desktopRatio,
    );
  }

  /// Build different layouts based on screen size
  static Widget builder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
  }) {
    final width = screenWidth(context);

    if (width >= desktopBreakpoint && largeDesktop != null) {
      return largeDesktop;
    } else if (width >= tabletBreakpoint && (desktop != null || largeDesktop != null)) {
      return desktop ?? largeDesktop ?? tablet ?? mobile;
    } else if (width >= mobileBreakpoint && tablet != null) {
      return tablet;
    }
    return mobile;
  }
}

/// Extension on BuildContext for easier responsive access
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isLargeDesktop => Responsive.isLargeDesktop(this);
  bool get isMobileOrTablet => Responsive.isMobileOrTablet(this);
  bool get isDesktopOrLarger => Responsive.isDesktopOrLarger(this);

  double get screenWidth => Responsive.screenWidth(this);
  double get screenHeight => Responsive.screenHeight(this);

  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) =>
      Responsive.value<T>(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      );
}
