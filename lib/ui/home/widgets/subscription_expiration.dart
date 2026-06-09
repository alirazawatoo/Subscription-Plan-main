import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_stacked_starter/utils/ui_helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

/// Summary of the plan the user is on: name, days left and expiry date.
class SubscriptionDetails extends ViewModelWidget<HomeViewModel> {
  const SubscriptionDetails({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final subscriptions = viewModel.subscriptions!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: kcSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: const FaIcon(
              FontAwesomeIcons.medal,
              size: 44,
              color: Colors.white,
            ),
          ),
          verticalSpaceRegular,
          Semantics(
            header: true,
            child: Text(
              '${subscriptions.plan} Plan',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
          verticalSpaceSmall,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kcAccentColor.withValues(alpha: 0.12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: kcAccentColor,
                  size: 20,
                ),
                horizontalSpaceSmall,
                Text(
                  '${subscriptions.daysLeft} days left',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: kcAccentColor,
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceSmall,
          Text(
            'Your ${subscriptions.plan} plan will expire on '
            '${subscriptions.date}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: kcMutedTextColor, fontSize: 15),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }
}
