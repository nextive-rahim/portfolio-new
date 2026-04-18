import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/data.dart';
import '../models/resume_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/reveal_on_scroll.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
      color: isDark ? const Color(0xFF0D1321) : const Color(0xFFF1F5F9),
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
                _buildProjectsGrid(context, isDark),
                SizedBox(height: context.responsive<double>(mobile: 48, tablet: 56, desktop: 64)),
                _buildPublishedApps(context, isDark),
                SizedBox(height: context.responsive<double>(mobile: 32, tablet: 40, desktop: 48)),
                _buildStatsBanner(context, isDark),
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
            'PROJECTS',
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
          'Featured Work',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(BuildContext context, bool isDark) {
    final crossAxisCount = context.responsive<int>(
      mobile: 1,
      tablet: 2,
      desktop: 2,
      largeDesktop: 3,
    );

    final childAspectRatio = context.responsive<double>(
      mobile: 1.4,
      tablet: 1.25,
      desktop: 1.2,
      largeDesktop: 1.1,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: context.responsive<double>(mobile: 16, tablet: 20, desktop: 24),
        mainAxisSpacing: context.responsive<double>(mobile: 16, tablet: 20, desktop: 24),
        childAspectRatio: childAspectRatio,
      ),
      itemCount: resumeData.majorProjects.length,
      itemBuilder: (context, index) {
        final project = resumeData.majorProjects[index];
        return _ProjectCard(
          project: project,
          isDark: isDark,
          isFeatured: index == 0,
        );
      },
    );
  }

  Widget _buildPublishedApps(BuildContext context, bool isDark) {
    final iosApps =
        resumeData.appLinks.where((app) => app.platform == AppPlatform.appStore).toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.apple,
              size: context.responsive<double>(mobile: 20, tablet: 22, desktop: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'iOS Apps on App Store',
              style: TextStyle(
                fontSize: context.responsive<double>(mobile: 20, tablet: 22, desktop: 24),
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: iosApps.map((app) {
            return _AppChip(app: app, isDark: isDark);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatsBanner(BuildContext context, bool isDark) {
    final stats = [
      {'icon': FontAwesomeIcons.android, 'value': '40+', 'label': 'Android Apps'},
      {'icon': FontAwesomeIcons.apple, 'value': '8+', 'label': 'iOS Apps'},
      {'icon': Icons.code, 'value': '5+', 'label': 'Backend Projects'},
      {'icon': Icons.speed, 'value': '60%', 'label': 'Performance Boost'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive<double>(mobile: 24, tablet: 28, desktop: 32),
        horizontal: context.responsive<double>(mobile: 16, tablet: 20, desktop: 24),
      ),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        spacing: context.responsive<double>(mobile: 24, tablet: 36, desktop: 48),
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: stats.map((stat) {
          return Column(
            children: [
              Icon(
                stat['icon'] as IconData,
                color: Colors.white,
                size: context.responsive<double>(mobile: 24, tablet: 26, desktop: 28),
              ),
              const SizedBox(height: 8),
              Text(
                stat['value'] as String,
                style: TextStyle(
                  fontSize: context.responsive<double>(mobile: 24, tablet: 26, desktop: 28),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                stat['label'] as String,
                style: TextStyle(
                  fontSize: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isDark;
  final bool isFeatured;

  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.isFeatured,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.responsive<double>(
      mobile: 20,
      tablet: 24,
      desktop: 28,
    );

    final titleSize = context.responsive<double>(
      mobile: 18,
      tablet: 20,
      desktop: 22,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                    color: AppTheme.primaryBlue.withValues(alpha: 0.15),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.responsive<double>(mobile: 10, tablet: 11, desktop: 12)),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.folder_outlined,
                          color: Colors.white,
                          size: context.responsive<double>(mobile: 20, tablet: 22, desktop: 24),
                        ),
                      ),
                      if (widget.isFeatured) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14)),
                              const SizedBox(width: 4),
                              Text(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: context.responsive<double>(mobile: 10, tablet: 11, desktop: 12),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.project.link != null)
                  IconButton(
                    onPressed: () async {
                      final uri = Uri.parse(widget.project.link!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    icon: Icon(
                      Icons.open_in_new,
                      color: widget.isDark ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.responsive<double>(mobile: 16, tablet: 18, desktop: 20)),
            Text(
              widget.project.name,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: widget.isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.project.description,
                style: TextStyle(
                  fontSize: context.responsive<double>(mobile: 13, tablet: 14, desktop: 15),
                  height: 1.5,
                  color: widget.isDark ? Colors.white70 : Colors.grey.shade600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.features.take(4).map((feature) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: context.responsive<double>(mobile: 10, tablet: 11, desktop: 12),
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppChip extends StatefulWidget {
  final AppLink app;
  final bool isDark;

  const _AppChip({required this.app, required this.isDark});

  @override
  State<_AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<_AppChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.app.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive<double>(mobile: 12, tablet: 14, desktop: 16),
            vertical: context.responsive<double>(mobile: 8, tablet: 9, desktop: 10),
          ),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.shade200),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.apple,
                size: context.responsive<double>(mobile: 14, tablet: 15, desktop: 16),
                color: widget.isDark ? Colors.white70 : Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                widget.app.name,
                style: TextStyle(
                  fontSize: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
                  fontWeight: FontWeight.w500,
                  color: widget.isDark ? Colors.white : Colors.grey.shade800,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_outward,
                size: context.responsive<double>(mobile: 12, tablet: 13, desktop: 14),
                color: _isHovered
                    ? AppTheme.primaryBlue
                    : (widget.isDark ? Colors.white54 : Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
