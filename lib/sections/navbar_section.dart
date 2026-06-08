import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class NavbarSection extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Function(String) onNavTap;
  final bool isScrolled;
  final String? activeSection;

  const NavbarSection({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onNavTap,
    this.isScrolled = false,
    this.activeSection,
  });

  @override
  State<NavbarSection> createState() => _NavbarSectionState();
}

class _NavbarSectionState extends State<NavbarSection> {
  bool _isMobileMenuOpen = false;

  final List<String> _navItems = [
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Contact'
  ];

  @override
  Widget build(BuildContext context) {
    final showFullNav = Responsive.isDesktopOrLarger(context);
    final horizontalPadding = context.responsive<double>(
      mobile: 16,
      tablet: 32,
      desktop: 48,
      largeDesktop: 64,
    );

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: widget.isScrolled ? 10 : 16,
          ),
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? const Color(0xFF0F172A).withValues(alpha: widget.isScrolled ? 0.9 : 0.8)
                : Colors.white.withValues(alpha: widget.isScrolled ? 0.9 : 0.8),
            border: Border(
              bottom: BorderSide(
                color: widget.isDarkMode
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade200,
              ),
            ),
            boxShadow: widget.isScrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: widget.isDarkMode ? 0.3 : 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              _buildLogo(),

              // Desktop Navigation
              if (showFullNav) ...[
                Row(
                  children: _navItems.map((item) {
                    return _NavItem(
                      label: item,
                      isDark: widget.isDarkMode,
                      isActive: widget.activeSection == item.toLowerCase(),
                      onTap: () => widget.onNavTap(item.toLowerCase()),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: widget.onToggleTheme,
                      icon: Icon(
                        widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: widget.isDarkMode ? Colors.white70 : Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _LetsTalkButton(isDark: widget.isDarkMode, onTap: () => widget.onNavTap('contact')),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    // Show theme toggle on tablet
                    if (Responsive.isTablet(context))
                      IconButton(
                        onPressed: widget.onToggleTheme,
                        icon: Icon(
                          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: widget.isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);
                        _showMobileMenu(context);
                      },
                      icon: Icon(
                        _isMobileMenuOpen ? Icons.close : Icons.menu,
                        color: widget.isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    final logoSize = context.responsive<double>(
      mobile: 14,
      tablet: 15,
      desktop: 16,
    );
    final nameSize = context.responsive<double>(
      mobile: 16,
      tablet: 17,
      desktop: 18,
    );

    return Row(
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
              fontSize: logoSize,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Abdul Rahim',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: nameSize,
            color: widget.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _MobileMenu(
        navItems: _navItems,
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.onToggleTheme,
        onNavTap: (section) {
          Navigator.pop(context);
          widget.onNavTap(section);
          setState(() => _isMobileMenuOpen = false);
        },
        onClose: () {
          Navigator.pop(context);
          setState(() => _isMobileMenuOpen = false);
        },
      ),
    ).then((_) {
      setState(() => _isMobileMenuOpen = false);
    });
  }
}

class _MobileMenu extends StatelessWidget {
  final List<String> navItems;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Function(String) onNavTap;
  final VoidCallback onClose;

  const _MobileMenu({
    required this.navItems,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onNavTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: EdgeInsets.only(
          top: 24,
          bottom: MediaQuery.of(context).padding.bottom + 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF0F172A).withValues(alpha: 0.95)
              : Colors.white.withValues(alpha: 0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Nav items
            ...navItems.map((item) => _MobileMenuItem(
                  label: item,
                  isDark: isDarkMode,
                  onTap: () => onNavTap(item.toLowerCase()),
                )),
            const SizedBox(height: 16),
            // Theme toggle for mobile
            if (Responsive.isMobile(context))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: onToggleTheme,
                      icon: Icon(
                        isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            // CTA Button
            SizedBox(
              width: double.infinity,
              child: _LetsTalkButton(
                isDark: isDarkMode,
                onTap: () => onNavTap('contact'),
                isFullWidth: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatefulWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<_MobileMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade200,
              ),
            ),
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _isHovered
                  ? AppTheme.primaryBlue
                  : (widget.isDark ? Colors.white : Colors.grey.shade800),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isDark;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isDark,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = _isHovered || widget.isActive;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isHighlighted
                      ? AppTheme.primaryBlue
                      : (widget.isDark ? Colors.white70 : Colors.grey.shade700),
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LetsTalkButton extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;
  final bool isFullWidth;

  const _LetsTalkButton({
    required this.isDark,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  State<_LetsTalkButton> createState() => _LetsTalkButtonState();
}

class _LetsTalkButtonState extends State<_LetsTalkButton> {
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
          padding: EdgeInsets.symmetric(
            horizontal: widget.isFullWidth ? 24 : 20,
            vertical: widget.isFullWidth ? 16 : 10,
          ),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(25),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Text(
            "Let's Talk",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: widget.isFullWidth ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
