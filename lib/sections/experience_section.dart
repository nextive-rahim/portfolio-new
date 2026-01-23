import 'package:flutter/material.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/reveal_on_scroll.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final horizontalPadding = context.responsive<double>(
      mobile: 20,
      tablet: 40,
      desktop: 80,
      largeDesktop: 120,
    );

    final verticalPadding = context.responsive<double>(
      mobile: 60,
      tablet: 70,
      desktop: 80,
      largeDesktop: 100,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: RevealOnScroll(
            child: Column(
              children: [
                _buildSectionHeader(context, isDark),
                SizedBox(height: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48)),
                _buildTimeline(context, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isDark) {
    final titleSize = context.responsive<double>(
      mobile: 32,
      tablet: 38,
      desktop: 42,
      largeDesktop: 48,
    );

    return Column(
      children: [
        Text(
          '03. EXPERIENCE',
          style: TextStyle(
            color: AppTheme.primaryBlue,
            fontFamily: 'monospace',
            fontSize: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(
                text: 'Work ',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              TextSpan(
                text: 'History',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = AppTheme.primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, titleSize * 4, titleSize),
                    ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context, bool isDark) {
    final useDesktopLayout = Responsive.isDesktopOrLarger(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Timeline line
            if (useDesktopLayout)
              Positioned(
                left: constraints.maxWidth / 2,
                top: 0,
                bottom: 0,
                child: Transform.translate(
                  offset: const Offset(-0.5, 0),
                  child: Container(
                    width: 1,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              )
            else
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFFE2E8F0),
                ),
              ),
            // Timeline items
            Column(
              children: List.generate(resumeData.experience.length, (index) {
                return _TimelineItem(
                  experience: resumeData.experience[index],
                  isFirst: index == 0,
                  isEven: index % 2 == 0,
                  isDark: isDark,
                  useDesktopLayout: useDesktopLayout,
                  index: index,
                  maxWidth: constraints.maxWidth,
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final dynamic experience;
  final bool isFirst;
  final bool isEven;
  final bool isDark;
  final bool useDesktopLayout;
  final int index;
  final double maxWidth;

  const _TimelineItem({
    required this.experience,
    required this.isFirst,
    required this.isEven,
    required this.isDark,
    required this.useDesktopLayout,
    required this.index,
    required this.maxWidth,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.experience.period.toLowerCase().contains('present');

    if (!widget.useDesktopLayout) {
      return _buildMobileLayout(context, isCurrent);
    }
    return _buildDesktopLayout(context, isCurrent);
  }

  Widget _buildMobileLayout(BuildContext context, bool isCurrent) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
          _buildTimelineDot(isCurrent),
          SizedBox(width: context.responsive<double>(mobile: 16, tablet: 20, desktop: 24)),
          // Content
          Expanded(child: _buildExperienceCard(context, isCurrent)),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Row(
        children: widget.isEven
            ? [
                // Content on right for even
                Expanded(child: const SizedBox()),
                _buildTimelineDot(isCurrent),
                const SizedBox(width: 48),
                Expanded(child: _buildExperienceCard(context, isCurrent)),
              ]
            : [
                // Content on left for odd
                Expanded(child: _buildExperienceCard(context, isCurrent)),
                const SizedBox(width: 48),
                _buildTimelineDot(isCurrent),
                Expanded(child: const SizedBox()),
              ],
      ),
    );
  }

  Widget _buildTimelineDot(bool isCurrent) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Ping animation for current
        if (isCurrent)
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryBlue.withValues(alpha: 0.5),
            ),
          ),
        if (isCurrent)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Container(
                width: 16 + (value * 20),
                height: 16 + (value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryBlue.withValues(alpha: 0.3 * (1 - value)),
                ),
              );
            },
            onEnd: () => setState(() {}),
          ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient,
            border: Border.all(
              color: widget.isDark ? const Color(0xFF0F172A) : Colors.white,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(BuildContext context, bool isCurrent) {
    final cardPadding = context.responsive<double>(
      mobile: 20,
      tablet: 26,
      desktop: 32,
    );

    final roleSize = context.responsive<double>(
      mobile: 18,
      tablet: 20,
      desktop: 22,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: widget.isDark
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(context.responsive<double>(mobile: 20, tablet: 26, desktop: 32)),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryBlue.withValues(alpha: 0.3)
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade200),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.experience.role.toUpperCase(),
                        style: TextStyle(
                          fontSize: roleSize,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          height: 1.1,
                          color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.experience.company.toUpperCase(),
                        style: TextStyle(
                          fontSize: context.responsive<double>(mobile: 10, tablet: 11, desktop: 11),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      'CURRENT',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.experience.period.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.responsive<double>(mobile: 10, tablet: 11, desktop: 11),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: widget.isDark ? Colors.white54 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.responsive<double>(mobile: 16, tablet: 20, desktop: 24)),
            ...widget.experience.bullets.take(4).map<Widget>((bullet) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryCyan,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        bullet,
                        style: TextStyle(
                          fontSize: context.responsive<double>(mobile: 13, tablet: 14, desktop: 14),
                          height: 1.7,
                          fontWeight: FontWeight.w500,
                          color: widget.isDark
                              ? Colors.white.withValues(alpha: 0.6)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
