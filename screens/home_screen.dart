import 'package:flutter/material.dart';
import 'package:starweaver/models/zodiac_sign.dart';
import 'package:starweaver/models/horoscope.dart';
import 'package:starweaver/services/storage_service.dart';
import 'package:starweaver/services/horoscope_service.dart';
import 'package:starweaver/widgets/horoscope_card.dart';
import 'package:starweaver/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ZodiacSign? userSign;
  Horoscope? dailyHoroscope;
  Horoscope? weeklyHoroscope;
  Horoscope? monthlyHoroscope;
  bool isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _loadUserData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final sign = await StorageService.getSavedZodiacSign();
    if (sign != null) {
      setState(() {
        userSign = sign;
      });
      
      await _loadHoroscopes();
    }
    
    setState(() {
      isLoading = false;
    });
    
    _animationController.forward();
  }

  Future<void> _loadHoroscopes() async {
    if (userSign == null) return;

    final futures = await Future.wait([
      HoroscopeService.getDailyHoroscope(userSign!),
      HoroscopeService.getWeeklyHoroscope(userSign!),
      HoroscopeService.getMonthlyHoroscope(userSign!),
    ]);

    setState(() {
      dailyHoroscope = futures[0];
      weeklyHoroscope = futures[1];
      monthlyHoroscope = futures[2];
    });
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: DarkModeColors.starGold,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: DarkModeColors.darkPrimary,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          DarkModeColors.cosmicGradientStart,
                          DarkModeColors.cosmicGradientStart.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                  title: userSign != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userSign!.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            userSign!.nameRu,
                            style: TextStyle(
                              color: DarkModeColors.starGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'StarWeaver',
                        style: TextStyle(
                          color: DarkModeColors.starGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  centerTitle: true,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (userSign != null) ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: DarkModeColors.darkSurface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: DarkModeColors.darkPrimary.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: DarkModeColors.darkPrimaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                userSign!.symbol,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: DarkModeColors.starGold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userSign!.nameRu,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: DarkModeColors.darkOnSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.public,
                                        size: 16,
                                        color: DarkModeColors.nebulaBlue,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        userSign!.element,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: DarkModeColors.nebulaBlue,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(
                                        Icons.brightness_7,
                                        size: 16,
                                        color: DarkModeColors.starGold,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        userSign!.planet,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: DarkModeColors.starGold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Text(
                        'Ваши предсказания',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: DarkModeColors.darkOnSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      if (dailyHoroscope != null)
                        HoroscopeCard(
                          title: 'Сегодня',
                          subtitle: 'Ежедневный гороскоп',
                          horoscope: dailyHoroscope!,
                          icon: Icons.wb_sunny,
                          iconColor: DarkModeColors.starGold,
                        ),
                      
                      if (weeklyHoroscope != null)
                        HoroscopeCard(
                          title: 'Эта неделя',
                          subtitle: 'Еженедельный прогноз',
                          horoscope: weeklyHoroscope!,
                          icon: Icons.calendar_view_week,
                          iconColor: DarkModeColors.nebulaBlue,
                        ),
                      
                      if (monthlyHoroscope != null)
                        HoroscopeCard(
                          title: 'Этот месяц',
                          subtitle: 'Ежемесячный прогноз',
                          horoscope: monthlyHoroscope!,
                          icon: Icons.calendar_view_month,
                          iconColor: DarkModeColors.darkTertiary,
                        ),
                    ] else
                      Container(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: DarkModeColors.darkPrimary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Данные не найдены',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: DarkModeColors.darkOnSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Пожалуйста, перезапустите приложение',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}