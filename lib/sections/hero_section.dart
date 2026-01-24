import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_flutter/src/core/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class HeroSection extends StatefulWidget {
  final Function(String) onNavTap;

  const HeroSection({super.key, required this.onNavTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final horizontalPadding = context.responsive<double>(
      mobile: 20,
      tablet: 40,
      desktop: 80,
      largeDesktop: 120,
    );

    final topPadding = context.responsive<double>(
      mobile: 60,
      tablet: 80,
      desktop: 100,
      largeDesktop: 120,
    );

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Stack(
        children: [
          // Animated Background Elements
          ..._buildBackgroundElements(isDark),
          // Grid Pattern
          _buildGridPattern(),
          // Main content
          Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: topPadding,
              bottom: 80,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.responsive<double>(
                    mobile: 500,
                    tablet: 700,
                    desktop: 900,
                    largeDesktop: 1000,
                  ),
                ),
                child: _buildContent(context, isDark),
              ),
            ),
          ),
          // Scroll Indicator
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: _buildScrollIndicator(isDark),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundElements(bool isDark) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Scale background elements based on screen size
    final pulseSize = context.responsive<double>(
      mobile: 250,
      tablet: 320,
      desktop: 384,
      largeDesktop: 450,
    );

    final secondaryPulseSize = context.responsive<double>(
      mobile: 200,
      tablet: 260,
      desktop: 320,
      largeDesktop: 380,
    );

    return [
      // Blue pulse
      Positioned(
        top: screenHeight * 0.25,
        left: screenWidth * 0.15,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: pulseSize,
              height: pulseSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryBlue.withValues(
                  alpha: 0.1 * (0.3 + _pulseController.value * 0.3),
                ),
              ),
            );
          },
        ),
      ),
      // Cyan pulse
      Positioned(
        bottom: screenHeight * 0.25,
        right: screenWidth * 0.15,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: secondaryPulseSize,
              height: secondaryPulseSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryCyan.withValues(
                  alpha: 0.1 * (0.3 + _pulseController.value * 0.3),
                ),
              ),
            );
          },
        ),
      ),
      // Floating circles
      Positioned.fill(
        child: AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: _FloatingCirclesPainter(
                offset: _floatAnimation.value,
                isDark: isDark,
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildGridPattern() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(
          painter: _GridPainter(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    final spacing = context.responsive<double>(
      mobile: 28,
      tablet: 32,
      desktop: 40,
      largeDesktop: 48,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile Image
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value * 0.5),
              child: _buildProfileImage(isDark),
            );
          },
        ),
        SizedBox(height: spacing),
        // Badge
        _buildBadge(isDark),
        SizedBox(height: spacing * 0.8),
        // Name
        _buildName(isDark),
        SizedBox(height: spacing * 0.6),
        // Title
        _buildTitle(),
        SizedBox(height: spacing * 0.6),
        // Description
        _buildDescription(isDark),
        SizedBox(height: spacing * 0.8),
        // Stats
        _buildStats(isDark),
        SizedBox(height: spacing),
        // CTA Buttons
        _buildButtons(isDark),
        SizedBox(height: spacing),
        // Social Links
        _buildSocialLinks(isDark),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark) {
    final size = context.responsive<double>(
      mobile: 120,
      tablet: 150,
      desktop: 180,
      largeDesktop: 200,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow
        Container(
          width: size + 20,
          height: size + 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 50,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
        // Profile circle
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
           Assets.images.profile.path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.primaryBlue,
                  child: Center(
                    child: Text(
                      'AR',
                      style: TextStyle(
                        fontSize: size * 0.35,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Verified badge
        Positioned(
          bottom: 0,
          right: size * 0.1,
          child: Container(
            width: context.responsive<double>(mobile: 32, tablet: 36, desktop: 40),
            height: context.responsive<double>(mobile: 32, tablet: 36, desktop: 40),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '✓',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.responsive<double>(mobile: 14, tablet: 16, desktop: 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(mobile: 12, tablet: 14, desktop: 16),
        vertical: context.responsive<double>(mobile: 8, tablet: 9, desktop: 10),
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'ACTIVE & AVAILABLE',
            style: TextStyle(
              fontSize: context.responsive<double>(mobile: 9, tablet: 10, desktop: 10),
              fontWeight: FontWeight.w900,
              letterSpacing: context.responsive<double>(mobile: 2, tablet: 2.5, desktop: 3),
              color: isDark ? Colors.white54 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildName(bool isDark) {
    final fontSize = context.responsive<double>(
      mobile: 40,
      tablet: 56,
      desktop: 72,
      largeDesktop: 84,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: -3,
          height: 1.0,
        ),
        children: [
          TextSpan(
            text: 'Abdul ',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          TextSpan(
            text: 'Rahim',
            style: TextStyle(
              foreground: Paint()
                ..shader = AppTheme.primaryGradient.createShader(
                  Rect.fromLTWH(0, 0, fontSize * 3, fontSize),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final fontSize = context.responsive<double>(
      mobile: 14,
      tablet: 17,
      desktop: 20,
      largeDesktop: 22,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          'FLUTTER DEVELOPER',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: AppTheme.primaryBlue,
          ),
        ),
        Text(
          ' & ',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.grey,
          ),
        ),
        Text(
          'BACKEND ENGINEER',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: AppTheme.primaryCyan,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(bool isDark) {
    final fontSize = context.responsive<double>(
      mobile: 14,
      tablet: 16,
      desktop: 18,
      largeDesktop: 20,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(mobile: 0, tablet: 20, desktop: 40),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: fontSize,
            height: 1.6,
            color: isDark ? Colors.white54 : Colors.grey.shade500,
          ),
          children: [
            const TextSpan(text: '4+ years building high-performance mobile apps with Flutter. Delivered '),
            TextSpan(
              text: '30+ Android',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const TextSpan(text: ' & '),
            TextSpan(
              text: '8+ iOS apps',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const TextSpan(text: ' to production.'),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(bool isDark) {
    final stats = [
      {'value': '4+', 'label': 'EXPERIENCE'},
      {'value': '38+', 'label': 'APPS'},
      {'value': '5+', 'label': 'BACKEND'},
    ];

    final valueSize = context.responsive<double>(
      mobile: 28,
      tablet: 34,
      desktop: 40,
      largeDesktop: 48,
    );

    final labelSize = context.responsive<double>(
      mobile: 9,
      tablet: 10,
      desktop: 10,
      largeDesktop: 11,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: context.responsive<double>(mobile: 24, tablet: 32, desktop: 40),
      runSpacing: 16,
      children: stats.map((stat) {
        return Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                stat['value']!,
                style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['label']!,
              style: TextStyle(
                fontSize: labelSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildButtons(bool isDark) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _CTAButton(
          label: 'PORTFOLIO',
          isPrimary: true,
          onTap: () => widget.onNavTap('projects'),
        ),
        _CTAButton(
          label: 'CONTACT ME',
          isPrimary: false,
          isDark: isDark,
          onTap: () => widget.onNavTap('contact'),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(bool isDark) {
    final socials = [
      {'icon': Icons.email_outlined, 'url': 'mailto:${resumeData.email}'},
      {'icon': FontAwesomeIcons.linkedin, 'url': 'https://${resumeData.linkedin}'},
      {'icon': FontAwesomeIcons.github, 'url': 'https://${resumeData.github}'},
      {'icon': Icons.phone_outlined, 'url': 'tel:${resumeData.phone}'},
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: socials.map((social) {
        return _SocialIcon(
          icon: social['icon'] as IconData,
          url: social['url'] as String,
          isDark: isDark,
        );
      }).toList(),
    );
  }

  Widget _buildScrollIndicator(bool isDark) {
    // Hide on mobile for more space
    if (context.isMobile) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value * 0.5),
          child: Column(
            children: [
              Text(
                'SCROLL',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: isDark ? Colors.white38 : Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: isDark ? Colors.white38 : Colors.grey.shade400,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FloatingCirclesPainter extends CustomPainter {
  final double offset;
  final bool isDark;

  _FloatingCirclesPainter({required this.offset, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryBlue.withValues(alpha: isDark ? 0.1 : 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Scale circles based on screen size
    final baseRadius = size.width < 600 ? 200.0 : 300.0;
    final largerRadius = size.width < 600 ? 280.0 : 400.0;

    // Large circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2 + offset),
      baseRadius,
      paint,
    );

    // Larger circle
    paint.color = AppTheme.primaryBlue.withValues(alpha: isDark ? 0.05 : 0.03);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2 + offset * 0.5),
      largerRadius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _FloatingCirclesPainter oldDelegate) {
    return offset != oldDelegate.offset;
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryBlue
      ..strokeWidth = 1;

    const gridSize = 50.0;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final bool isDark;
  final VoidCallback onTap;

  const _CTAButton({
    required this.label,
    required this.isPrimary,
    this.isDark = true,
    required this.onTap,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.responsive<double>(
      mobile: 28,
      tablet: 34,
      desktop: 40,
    );
    final verticalPadding = context.responsive<double>(
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );
    final fontSize = context.responsive<double>(
      mobile: 10,
      tablet: 11,
      desktop: 11,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: widget.isPrimary ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: widget.isDark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.grey.shade300,
                  ),
            boxShadow: widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.4),
                      blurRadius: _isHovered ? 30 : 20,
                      offset: const Offset(0, 10),
                    )
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: widget.isPrimary
                  ? Colors.white
                  : (widget.isDark ? Colors.white : const Color(0xFF0F172A)),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final bool isDark;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.isDark,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = context.responsive<double>(
      mobile: 44,
      tablet: 46,
      desktop: 48,
    );
    final iconSize = context.responsive<double>(
      mobile: 18,
      tablet: 19,
      desktop: 20,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue.withValues(alpha: 0.5)
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.shade200),
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: iconSize,
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDark ? Colors.white54 : Colors.grey.shade500),
            ),
          ),
        ),
      ),
    );
  }
}
