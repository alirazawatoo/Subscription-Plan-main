import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';

class PlansTitle extends StatelessWidget {
  const PlansTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider(color: kcSurfaceColor, thickness: 1)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: kcSurfaceColor,
            ),
            child: Semantics(
              header: true,
              child: const Text(
                'PLANS',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                  color: kcTextColor,
                ),
              ),
            ),
          ),
          const Expanded(child: Divider(color: kcSurfaceColor, thickness: 1)),
        ],
      ),
    );
  }
}
