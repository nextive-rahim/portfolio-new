import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
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

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        title: 'Abdul Rahim | Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        home: const PortfolioHome(),
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  bool _isScrolled = false;
  String _activeSection = 'about';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 10;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
    _updateActiveSection();
  }

  void _updateActiveSection() {
    final sections = <String, GlobalKey>{
      'about': aboutKey,
      'skills': skillsKey,
      'experience': experienceKey,
      'projects': projectsKey,
      'contact': contactKey,
    };

    // The last section whose top has scrolled above the navbar is the active
    // one; default to the first item ('about') while still near the top.
    const triggerOffset = 120.0;
    String current = 'about';
    for (final entry in sections.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= triggerOffset) {
        current = entry.key;
      }
    }

    if (current != _activeSection) {
      setState(() => _activeSection = current);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'about':
        key = aboutKey;
        break;
      case 'skills':
        key = skillsKey;
        break;
      case 'experience':
        key = experienceKey;
        break;
      case 'projects':
        key = projectsKey;
        break;
      case 'contact':
        key = contactKey;
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
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeroSection(onNavTap: _scrollToSection),
                    Container(key: aboutKey, child: const AboutSection()),
                    Container(key: skillsKey, child: const SkillsSection()),
                    Container(
                      key: experienceKey,
                      child: const ExperienceSection(),
                    ),
                    Container(key: projectsKey, child: const ProjectsSection()),
                    Container(key: contactKey, child: const ContactSection()),
                    const FooterSection(),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => NavbarSection(
              isDarkMode: themeController.isDarkMode,
              onToggleTheme: themeController.toggleTheme,
              onNavTap: _scrollToSection,
              isScrolled: _isScrolled,
              activeSection: _activeSection,
            ),
          ),
          const Positioned(
            bottom: 24,
            right: 24,
            child: _FloatingThemeToggle(),
          ),
        ],
      ),
    );
  }
}

class _FloatingThemeToggle extends StatelessWidget {
  const _FloatingThemeToggle();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isHovered = false.obs;

    if (Responsive.isDesktopOrLarger(context)) return const SizedBox.shrink();

    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: GestureDetector(
          onTap: themeController.toggleTheme,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryBlue.withValues(
                    alpha: isHovered.value ? 0.5 : 0.3,
                  ),
                  blurRadius: isHovered.value ? 20 : 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
