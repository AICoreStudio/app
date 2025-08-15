import 'package:flutter/material.dart';
import 'package:starweaver/services/storage_service.dart';
import 'package:starweaver/models/zodiac_sign.dart';
import 'package:starweaver/screens/main_screen.dart';
import 'package:starweaver/theme.dart';

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key});

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> with TickerProviderStateMixin {
  DateTime? selectedDate;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _checkExistingUser();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingUser() async {
    final hasUser = await StorageService.hasUserData();
    if (hasUser) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: DarkModeColors.darkPrimary,
              onPrimary: DarkModeColors.darkOnPrimary,
              surface: DarkModeColors.darkSurface,
              onSurface: DarkModeColors.darkOnSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _continueToApp() async {
    if (selectedDate != null) {
      await StorageService.saveBirthdate(selectedDate!);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainScreen(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    }
  }

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
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: DarkModeColors.starGold,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: DarkModeColors.darkPrimaryContainer,
                        child: Icon(
                          Icons.auto_awesome,
                          size: 60,
                          color: DarkModeColors.starGold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'StarWeaver',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: DarkModeColors.starGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Космический Гороскоп',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: DarkModeColors.darkOnSurface,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: DarkModeColors.darkSurface.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: DarkModeColors.darkPrimary.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Выберите дату рождения',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: DarkModeColors.darkOnSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Мы определим ваш знак зодиака и подберем персональные предсказания',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: DarkModeColors.darkOnSurface.withValues(alpha: 0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          if (selectedDate != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: DarkModeColors.darkPrimaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: DarkModeColors.nebulaBlue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${selectedDate!.day}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.year}',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: DarkModeColors.darkOnPrimaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: DarkModeColors.darkPrimaryContainer.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ZodiacSign.getSignByDate(selectedDate!).emoji,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Ваш знак: ${ZodiacSign.getSignByDate(selectedDate!).nameRu}',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: DarkModeColors.darkOnPrimaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (selectedDate == null)
                      ElevatedButton.icon(
                        onPressed: _selectDate,
                        icon: Icon(
                          Icons.calendar_today,
                          color: DarkModeColors.darkOnPrimary,
                        ),
                        label: Text(
                          'Выбрать дату',
                          style: TextStyle(color: DarkModeColors.darkOnPrimary),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DarkModeColors.darkPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: _continueToApp,
                        icon: Icon(
                          Icons.auto_awesome,
                          color: DarkModeColors.darkOnPrimary,
                        ),
                        label: Text(
                          'Войти в космос',
                          style: TextStyle(color: DarkModeColors.darkOnPrimary),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DarkModeColors.darkPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}