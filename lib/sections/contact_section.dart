import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/reveal_on_scroll.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'CONTACT',
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
          "Let's Work Together",
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
    final useRowLayout = Responsive.isDesktopOrLarger(context);

    if (useRowLayout) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildContactCards(context, isDark),
          ),
          SizedBox(width: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48)),
          Expanded(
            flex: 2,
            child: _buildCTACard(context, isDark),
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildContactCards(context, isDark),
        const SizedBox(height: 32),
        _buildCTACard(context, isDark),
      ],
    );
  }

  Widget _buildContactCards(BuildContext context, bool isDark) {
    return Column(
      children: [
        _ContactCard(
          icon: Icons.email_outlined,
          title: 'Email',
          value: resumeData.email,
          url: 'mailto:${resumeData.email}',
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: resumeData.phone,
          url: 'tel:${resumeData.phone}',
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _ContactCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: resumeData.location,
          isDark: isDark,
        ),
        const SizedBox(height: 24),
        _buildSocialCards(context, isDark),
      ],
    );
  }

  Widget _buildSocialCards(BuildContext context, bool isDark) {
    // On mobile, stack vertically; otherwise side by side
    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          _SocialCard(
            icon: FontAwesomeIcons.linkedin,
            label: 'LinkedIn',
            url: 'https://${resumeData.linkedin}',
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _SocialCard(
            icon: FontAwesomeIcons.github,
            label: 'GitHub',
            url: 'https://${resumeData.github}',
            isDark: isDark,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _SocialCard(
            icon: FontAwesomeIcons.linkedin,
            label: 'LinkedIn',
            url: 'https://${resumeData.linkedin}',
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _SocialCard(
            icon: FontAwesomeIcons.github,
            label: 'GitHub',
            url: 'https://${resumeData.github}',
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildCTACard(BuildContext context, bool isDark) {
    final cardPadding = context.responsive<double>(
      mobile: 24,
      tablet: 28,
      desktop: 32,
    );

    final titleSize = context.responsive<double>(
      mobile: 20,
      tablet: 22,
      desktop: 24,
    );

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.rocket_launch,
            color: Colors.white,
            size: context.responsive<double>(mobile: 40, tablet: 44, desktop: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Ready to start a project?',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Let's discuss how I can help bring your ideas to life with Flutter and modern backend technologies.",
            style: TextStyle(
              fontSize: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
              height: 1.6,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 32),
          _CTAButton(
            label: 'Send Email',
            icon: Icons.email_outlined,
            onTap: () async {
              final uri = Uri.parse('mailto:${resumeData.email}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),
          const SizedBox(height: 12),
          _CTAButton(
            label: 'WhatsApp',
            icon: FontAwesomeIcons.whatsapp,
            onTap: () async {
              final uri = Uri.parse('https://wa.me/${resumeData.phone}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            isOutline: true,
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? url;
  final bool isDark;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    this.url,
    required this.isDark,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.responsive<double>(
      mobile: 18,
      tablet: 21,
      desktop: 24,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.url != null
            ? () async {
                final uri = Uri.parse(widget.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade200),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.responsive<double>(mobile: 12, tablet: 13, desktop: 14)),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: AppTheme.primaryBlue,
                  size: context.responsive<double>(mobile: 20, tablet: 22, desktop: 24),
                ),
              ),
              SizedBox(width: context.responsive<double>(mobile: 16, tablet: 18, desktop: 20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: context.responsive<double>(mobile: 12, tablet: 12, desktop: 13),
                        color: widget.isDark ? Colors.white54 : Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: TextStyle(
                        fontSize: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
                        fontWeight: FontWeight.w600,
                        color: widget.isDark ? Colors.white : Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.url != null)
                Icon(
                  Icons.arrow_outward,
                  color: _isHovered
                      ? AppTheme.primaryBlue
                      : (widget.isDark ? Colors.white30 : Colors.grey.shade400),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isDark;

  const _SocialCard({
    required this.icon,
    required this.label,
    required this.url,
    required this.isDark,
  });

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.responsive<double>(
      mobile: 16,
      tablet: 18,
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
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade200),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: _isHovered
                    ? AppTheme.primaryBlue
                    : (widget.isDark ? Colors.white70 : Colors.grey.shade700),
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.isDark ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isOutline;

  const _CTAButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isOutline = false,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
          ),
          decoration: BoxDecoration(
            color: widget.isOutline
                ? (_isHovered ? Colors.white.withValues(alpha: 0.1) : Colors.transparent)
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: widget.isOutline
                ? Border.all(color: Colors.white.withValues(alpha: 0.5))
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.isOutline ? Colors.white : AppTheme.primaryBlue,
                size: context.responsive<double>(mobile: 18, tablet: 19, desktop: 20),
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isOutline ? Colors.white : AppTheme.primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
