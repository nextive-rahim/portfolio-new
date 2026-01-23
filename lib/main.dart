import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'utils/responsive.dart';
import 'sections/navbar_section.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdul Rahim | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: PortfolioHome(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const PortfolioHome({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'about':
        key = _aboutKey;
        break;
      case 'skills':
        key = _skillsKey;
        break;
      case 'experience':
        key = _experienceKey;
        break;
      case 'projects':
        key = _projectsKey;
        break;
      case 'contact':
        key = _contactKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Navbar
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 80,
                flexibleSpace: NavbarSection(
                  isDarkMode: widget.isDarkMode,
                  onToggleTheme: widget.onToggleTheme,
                  onNavTap: _scrollToSection,
                ),
              ),

              // Sections
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeroSection(onNavTap: _scrollToSection),
                    Container(key: _aboutKey, child: const AboutSection()),
                    Container(key: _skillsKey, child: const SkillsSection()),
                    Container(key: _experienceKey, child: const ExperienceSection()),
                    Container(key: _projectsKey, child: const ProjectsSection()),
                    Container(key: _contactKey, child: const ContactSection()),
                    const FooterSection(),
                  ],
                ),
              ),
            ],
          ),

          // Floating theme toggle (mobile)
          Positioned(
            bottom: 24,
            right: 24,
            child: _FloatingThemeToggle(
              isDarkMode: widget.isDarkMode,
              onToggle: widget.onToggleTheme,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingThemeToggle extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _FloatingThemeToggle({
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  State<_FloatingThemeToggle> createState() => _FloatingThemeToggleState();
}

class _FloatingThemeToggleState extends State<_FloatingThemeToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Hide on tablet and larger screens
    if (Responsive.isDesktopOrLarger(context)) return const SizedBox.shrink();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: _isHovered ? 0.5 : 0.3),
                blurRadius: _isHovered ? 20 : 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
