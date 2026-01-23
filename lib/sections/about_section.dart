import 'package:flutter/material.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, isDark),
                SizedBox(height: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48)),
                _buildContent(context, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isDark) {
    final titleSize = context.responsive<double>(
      mobile: 28,
      tablet: 32,
      desktop: 36,
      largeDesktop: 40,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'ABOUT ME',
            style: TextStyle(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Professional Summary',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    // Use column layout for mobile and tablet portrait, row for larger screens
    final useRowLayout = Responsive.isDesktopOrLarger(context);

    if (useRowLayout) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildAboutContent(context, isDark),
          ),
          SizedBox(width: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48, largeDesktop: 64)),
          Expanded(
            flex: 2,
            child: _buildStatsCard(context, isDark),
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildAboutContent(context, isDark),
        const SizedBox(height: 32),
        _buildStatsCard(context, isDark),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context, bool isDark) {
    final textSize = context.responsive<double>(
      mobile: 15,
      tablet: 16,
      desktop: 18,
      largeDesktop: 18,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          resumeData.summary,
          style: TextStyle(
            fontSize: textSize,
            height: 1.8,
            color: isDark ? Colors.white70 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 32),
        _buildContactInfo(context, isDark),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isDark) {
    final contacts = [
      {'icon': Icons.email_outlined, 'label': 'Email', 'value': resumeData.email},
      {'icon': Icons.phone_outlined, 'label': 'Phone', 'value': resumeData.phone},
      {'icon': Icons.location_on_outlined, 'label': 'Location', 'value': resumeData.location},
    ];

    // On tablet, show contacts in a row
    if (Responsive.isTablet(context)) {
      return Wrap(
        spacing: 24,
        runSpacing: 16,
        children: contacts.map((contact) => _buildContactItem(context, contact, isDark)).toList(),
      );
    }

    return Column(
      children: contacts.map((contact) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildContactItem(context, contact, isDark),
        );
      }).toList(),
    );
  }

  Widget _buildContactItem(BuildContext context, Map<String, dynamic> contact, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            contact['icon'] as IconData,
            color: AppTheme.primaryBlue,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact['label'] as String,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.grey.shade500,
              ),
            ),
            Text(
              contact['value'] as String,
              style: TextStyle(
                fontSize: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context, bool isDark) {
    final statValueSize = context.responsive<double>(
      mobile: 32,
      tablet: 34,
      desktop: 36,
      largeDesktop: 40,
    );

    return GlassCard(
      padding: EdgeInsets.all(context.responsive<double>(mobile: 24, tablet: 28, desktop: 32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Open to Work',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildStatItem('4+', 'Years of Experience', isDark, statValueSize),
          const Divider(height: 40),
          _buildStatItem('38+', 'Apps Delivered', isDark, statValueSize),
          const Divider(height: 40),
          _buildStatItem('5+', 'Backend Projects', isDark, statValueSize),
          const Divider(height: 40),
          _buildStatItem('100%', 'Client Satisfaction', isDark, statValueSize),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, bool isDark, double valueSize) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
