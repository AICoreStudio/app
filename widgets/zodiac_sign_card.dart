import 'package:flutter/material.dart';
import 'package:starweaver/models/zodiac_sign.dart';
import 'package:starweaver/theme.dart';

class ZodiacSignCard extends StatelessWidget {
  final ZodiacSign sign;
  final Color elementColor;

  const ZodiacSignCard({
    super.key,
    required this.sign,
    required this.elementColor,
  });

  String _formatDateRange() {
    final startDay = sign.startDate.day;
    final startMonth = _getMonthName(sign.startDate.month);
    final endDay = sign.endDate.day;
    final endMonth = _getMonthName(sign.endDate.month);
    
    return '$startDay $startMonth - $endDay $endMonth';
  }

  String _getMonthName(int month) {
    const months = [
      '', 'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: elementColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            surface: Colors.transparent,
          ),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  elementColor.withValues(alpha: 0.3),
                  elementColor.withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: elementColor.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sign.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  sign.symbol,
                  style: TextStyle(
                    fontSize: 16,
                    color: elementColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            sign.nameRu,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: DarkModeColors.darkOnSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                _formatDateRange(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: elementColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.brightness_7,
                    size: 16,
                    color: DarkModeColors.starGold,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    sign.planet,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: DarkModeColors.starGold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          iconColor: elementColor,
          collapsedIconColor: elementColor,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    elementColor.withValues(alpha: 0.1),
                    elementColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: elementColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: elementColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.public,
                              size: 16,
                              color: elementColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Стихия: ${sign.element}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: elementColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Характеристика знака',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: DarkModeColors.darkOnSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sign.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: DarkModeColors.darkOnSurface.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.date_range,
                        label: _formatDateRange(),
                        color: DarkModeColors.nebulaBlue,
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}