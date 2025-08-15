import 'package:flutter/material.dart';
import 'package:starweaver/models/zodiac_sign.dart';
import 'package:starweaver/widgets/zodiac_sign_card.dart';
import 'package:starweaver/theme.dart';

class ZodiacSignsScreen extends StatefulWidget {
  const ZodiacSignsScreen({super.key});

  @override
  State<ZodiacSignsScreen> createState() => _ZodiacSignsScreenState();
}

class _ZodiacSignsScreenState extends State<ZodiacSignsScreen> with TickerProviderStateMixin {
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
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, List<ZodiacSign>> _groupSignsByElement() {
    final Map<String, List<ZodiacSign>> grouped = {};
    
    for (final sign in ZodiacSign.signs) {
      if (!grouped.containsKey(sign.element)) {
        grouped[sign.element] = [];
      }
      // Избегаем дублирования Козерога
      if (!grouped[sign.element]!.any((s) => s.name == sign.name && s.nameRu == sign.nameRu)) {
        grouped[sign.element]!.add(sign);
      }
    }
    
    return grouped;
  }

  Color _getElementColor(String element) {
    switch (element) {
      case 'Огонь':
        return Colors.orange;
      case 'Земля':
        return Colors.brown;
      case 'Воздух':
        return DarkModeColors.nebulaBlue;
      case 'Вода':
        return Colors.blue;
      default:
        return DarkModeColors.darkPrimary;
    }
  }

  IconData _getElementIcon(String element) {
    switch (element) {
      case 'Огонь':
        return Icons.local_fire_department;
      case 'Земля':
        return Icons.terrain;
      case 'Воздух':
        return Icons.air;
      case 'Вода':
        return Icons.water_drop;
      default:
        return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedSigns = _groupSignsByElement();
    final elementOrder = ['Огонь', 'Земля', 'Воздух', 'Вода'];

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
                  title: Text(
                    'Знаки Зодиака',
                    style: TextStyle(
                      color: DarkModeColors.starGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final element = elementOrder[index];
                      final signs = groupedSigns[element] ?? [];
                      final elementColor = _getElementColor(element);
                      final elementIcon = _getElementIcon(element);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  elementColor.withValues(alpha: 0.3),
                                  elementColor.withValues(alpha: 0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: elementColor.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  elementIcon,
                                  color: elementColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  element,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: elementColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: elementColor.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${signs.length} знака',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: elementColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...signs.map((sign) => AnimatedContainer(
                            duration: Duration(milliseconds: 400 + (signs.indexOf(sign) * 100)),
                            curve: Curves.easeOutBack,
                            child: ZodiacSignCard(
                              sign: sign,
                              elementColor: elementColor,
                            ),
                          )),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                    childCount: elementOrder.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}