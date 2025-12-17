import 'package:flutter/material.dart';
import 'package:rifq/core/theme/app_theme.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [

          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(24),
              ),
              child: Container(
                height: double.infinity,
                color: Colors.grey[300],
                child: Image.asset(
                'assets/images/8.png',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              ),

              // child: Image.asset(
              //   'assets/images/modern_clinic.png',
              //   height: double.infinity,
              //   fit: BoxFit.cover,
              // ),

            ),
          ),

          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Modern Vet Clinic",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.neutral900,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    "Book a check-up for your pet with trusted vets and full-care services.",
                    style: context.body3,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                   SizedBox(height: 12),
                  Row(
                    children:  [
                      _InfoChip(
                        icon: Icons.star_border,
                        label: "4.9",
                      ),
                      SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.place_outlined,
                        label: "1.5 Km",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//!=================chip widget =====================

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.primary50.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.primary50),
           SizedBox(width: 4),
          Text(
            label,
            style: context.body3.copyWith(color: context.primary50),
          ),
        ],
      ),
    );
  }
}
