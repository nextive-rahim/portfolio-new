import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

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
      mobile: 32,
      tablet: 36,
      desktop: 40,
    );

    // Use column layout for mobile, row for larger screens
    final useRowLayout = Responsive.isDesktopOrLarger(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D1321) : const Color(0xFFF1F5F9),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey.shade200,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: useRowLayout
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(context, isDark),
                    _buildCopyright(context, isDark),
                    _buildSocialLinks(context, isDark),
                  ],
                )
              : Column(
                  children: [
                    _buildLogo(context, isDark),
                    const SizedBox(height: 24),
                    _buildSocialLinks(context, isDark),
                    const SizedBox(height: 24),
                    _buildCopyright(context, isDark),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'AR',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          resumeData.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
            color: isDark ? Colors.white : Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildCopyright(BuildContext context, bool isDark) {
    return Column(
      children: [
        Text(
          '© ${DateTime.now().year} ${resumeData.name}. All rights reserved.',
          style: TextStyle(
            fontSize: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
            color: isDark ? Colors.white54 : Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Built with ',
              style: TextStyle(
                fontSize: context.responsive<double>(mobile: 11, tablet: 12, desktop: 13),
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
            ),
            const Icon(
              Icons.favorite,
              size: 14,
              color: Colors.red,
            ),
            Text(
              ' using Flutter',
              style: TextStyle(
                fontSize: context.responsive<double>(mobile: 11, tablet: 12, desktop: 13),
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context, bool isDark) {
    final socials = [
      {'icon': FontAwesomeIcons.linkedin, 'url': 'https://${resumeData.linkedin}'},
      {'icon': FontAwesomeIcons.github, 'url': 'https://${resumeData.github}'},
      {'icon': Icons.email_outlined, 'url': 'mailto:${resumeData.email}'},
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: socials.map((social) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _FooterSocialButton(
            icon: social['icon'] as IconData,
            url: social['url'] as String,
            isDark: isDark,
          ),
        );
      }).toList(),
    );
  }
}

class _FooterSocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final bool isDark;

  const _FooterSocialButton({
    required this.icon,
    required this.url,
    required this.isDark,
  });

  @override
  State<_FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<_FooterSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final buttonPadding = context.responsive<double>(
      mobile: 8,
      tablet: 9,
      desktop: 10,
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
          padding: EdgeInsets.all(buttonPadding),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primaryBlue.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.icon,
            size: iconSize,
            color: _isHovered
                ? AppTheme.primaryBlue
                : (widget.isDark ? Colors.white54 : Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
