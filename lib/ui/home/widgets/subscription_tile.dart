import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/models/application_models.dart';
import 'package:flutter_stacked_starter/utils/ui_helpers.dart';

class SubscriptionTile extends StatelessWidget {
  const SubscriptionTile({
    super.key,
    required this.plan,
    required this.icon,
    required this.selected,
    required this.current,
    required this.onTap,
  });

  final Subscription plan;
  final IconData icon;
  final bool selected;

  /// Whether this is the plan the user is subscribed to now.
  final bool current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: selected ? kcSecondaryColor : const Color(0x55EBEBF0),
        width: selected ? 2 : 1,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Semantics(
        selected: selected,
        inMutuallyExclusiveGroup: true,
        child: Material(
          color: selected ? kcSurfaceColor : Colors.transparent,
          shape: shape,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 14),
                  for (final feature in plan.features) _featureRow(feature),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: kcSecondaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kcTextColor,
                ),
              ),
              if (current)
                const Text(
                  'Current plan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kcAccentColor,
                  ),
                ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: plan.formattedPrice,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kcTextColor,
            ),
            children: [
              TextSpan(
                text: ' / ${plan.billingPeriod}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcMutedTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _featureRow(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kcSecondaryColor),
            ),
            child: const Icon(Icons.check, color: kcSecondaryColor, size: 12),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(fontSize: 15, color: kcTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
