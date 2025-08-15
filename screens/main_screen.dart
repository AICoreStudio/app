import 'package:flutter/material.dart';
import 'package:starweaver/screens/home_screen.dart';
import 'package:starweaver/screens/zodiac_signs_screen.dart';
import 'package:starweaver/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const ZodiacSignsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DarkModeColors.cosmicGradientStart,
              DarkModeColors.cosmicGradientEnd,
            ],
          ),
        ),
        child: _screens[_currentIndex],
      ),
      floatingActionButton: Container(
        height: 70,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              DarkModeColors.darkPrimary.withValues(alpha: 0.9),
              DarkModeColors.darkSecondary.withValues(alpha: 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: DarkModeColors.darkPrimary.withValues(alpha: 0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.auto_awesome,
              label: 'Гороскоп',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.stars,
              label: 'Знаки',
              index: 1,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive 
            ? DarkModeColors.starGold.withValues(alpha: 0.2)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? DarkModeColors.starGold : DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? DarkModeColors.starGold : DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}