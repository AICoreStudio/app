import 'package:flutter/material.dart';
import 'package:starweaver/models/horoscope.dart';
import 'package:starweaver/theme.dart';

class HoroscopeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Horoscope horoscope;
  final IconData icon;
  final Color iconColor;

  const HoroscopeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.horoscope,
    required this.icon,
    required this.iconColor,
  });

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: DarkModeColors.starGold,
          size: 14,
        );
      }),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData sectionIcon,
    required Color sectionColor,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkModeColors.darkPrimaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: sectionColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                sectionIcon,
                size: 18,
                color: sectionColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: sectionColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: DarkModeColors.darkOnSurface.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.3),
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
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          title: Text(
            title,
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
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Рейтинг дня: ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: DarkModeColors.darkOnSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  _buildStarRating(horoscope.rating),
                ],
              ),
            ],
          ),
          iconColor: iconColor,
          collapsedIconColor: iconColor,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: DarkModeColors.darkPrimaryContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Общий прогноз',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: DarkModeColors.darkOnSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    horoscope.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: DarkModeColors.darkOnSurface.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'Любовь',
              content: horoscope.love,
              sectionIcon: Icons.favorite,
              sectionColor: Colors.pink,
              context: context,
            ),
            _buildSection(
              title: 'Карьера',
              content: horoscope.career,
              sectionIcon: Icons.work,
              sectionColor: DarkModeColors.nebulaBlue,
              context: context,
            ),
            _buildSection(
              title: 'Здоровье',
              content: horoscope.health,
              sectionIcon: Icons.health_and_safety,
              sectionColor: Colors.green,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}