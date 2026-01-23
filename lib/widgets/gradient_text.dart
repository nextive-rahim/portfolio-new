import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          (gradient ?? AppTheme.primaryGradient).createShader(bounds),
      child: Text(
        text,
        style: (style ?? Theme.of(context).textTheme.displayLarge)?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
