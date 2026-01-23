import 'package:flutter/material.dart';
import '../data/data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/reveal_on_scroll.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                _buildSkillsGrid(context, isDark),
                SizedBox(height: context.responsive<double>(mobile: 48, tablet: 56, desktop: 64)),
                _buildTechMarquee(context, isDark),
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
            'SKILLS & EXPERTISE',
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
          'Technical Proficiency',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isDark) {
    final skillCategories = [
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Development',
        'skills': resumeData.coreSkills[0].skills,
        'color': AppTheme.primaryBlue,
      },
      {
        'icon': Icons.code,
        'title': 'Backend Development',
        'skills': resumeData.coreSkills[1].skills,
        'color': AppTheme.primaryCyan,
      },
      {
        'icon': Icons.storage,
        'title': 'Database & Cloud',
        'skills': ['MongoDB', 'PostgreSQL', 'Firebase', 'Supabase', 'AWS S3'],
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.speed,
        'title': 'Performance',
        'skills': resumeData.coreSkills[2].skills,
        'color': const Color(0xFFF59E0B),
      },
    ];

    final spacing = context.responsive<double>(mobile: 16, tablet: 20, desktop: 24);

    final screenWidth = MediaQuery.of(context).size.width;
    final columnsCount = context.responsive<int>(
      mobile: 1,
      tablet: 2,
      desktop: 2,
      largeDesktop: 4,
    );

    // Calculate card width based on available space and columns
    final availableWidth = screenWidth - (spacing * (columnsCount - 1));
    final cardWidth = (availableWidth / columnsCount).clamp(280.0, 400.0);

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: skillCategories.map((category) {
        return SizedBox(
          width: columnsCount == 1 ? double.infinity : cardWidth,
          child: _SkillCard(
            icon: category['icon'] as IconData,
            title: category['title'] as String,
            skills: category['skills'] as List<String>,
            color: category['color'] as Color,
            isDark: isDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTechMarquee(BuildContext context, bool isDark) {
    final technologies = [
      'Flutter',
      'Dart',
      'Node.js',
      'NestJS',
      'Express.js',
      'MongoDB',
      'PostgreSQL',
      'Firebase',
      'REST API',
      'GraphQL',
      'GetX',
      'Bloc',
      'Riverpod',
      'Git',
      'Docker',
    ];

    return Column(
      children: [
        Text(
          'Technologies I Work With',
          style: TextStyle(
            fontSize: context.responsive<double>(mobile: 16, tablet: 17, desktop: 18),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 50,
          child: _MarqueeWidget(
            children: technologies.map((tech) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsive<double>(mobile: 16, tablet: 18, desktop: 20),
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SkillCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<String> skills;
  final Color color;
  final bool isDark;

  const _SkillCard({
    required this.icon,
    required this.title,
    required this.skills,
    required this.color,
    required this.isDark,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.responsive<double>(
      mobile: 20,
      tablet: 24,
      desktop: 28,
    );

    final titleSize = context.responsive<double>(
      mobile: 16,
      tablet: 17,
      desktop: 18,
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
                ? widget.color
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade200),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.responsive<double>(mobile: 10, tablet: 11, desktop: 12)),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: context.responsive<double>(mobile: 20, tablet: 22, desktop: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: widget.isDark ? Colors.white : Colors.grey.shade900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.responsive<double>(mobile: 16, tablet: 18, desktop: 20)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: context.responsive<double>(mobile: 12, tablet: 12, desktop: 13),
                      color: widget.isDark ? Colors.white70 : Colors.grey.shade700,
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

class _MarqueeWidget extends StatefulWidget {
  final List<Widget> children;

  const _MarqueeWidget({required this.children});

  @override
  State<_MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<_MarqueeWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _animationController.addListener(() {
      if (_scrollController.hasClients &&
          _scrollController.position.hasContentDimensions) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = maxScroll * _animationController.value;
        _scrollController.jumpTo(currentScroll);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [...widget.children, ...widget.children],
      ),
    );
  }
}
