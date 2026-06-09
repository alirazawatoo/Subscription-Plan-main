import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/subscription_tile.dart';
import 'package:stacked/stacked.dart';

import 'activation_upgrade_button.dart';

class PlansList extends ViewModelWidget<HomeViewModel> {
  const PlansList({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final plans = viewModel.plans;
    final selected = viewModel.selectedPlan;
    return Column(
      children: [
        for (var index = 0; index < plans.length; index++)
          SubscriptionTile(
            plan: plans[index],
            icon: viewModel.getIcon(index),
            selected: viewModel.selectedIndex == index,
            current: plans[index].name == viewModel.subscriptions?.plan,
            onTap: () => viewModel.setSelectedIndex(index),
          ),
        ActivationUpgradeButton(
          title: viewModel.isCurrentPlanSelected || selected == null
              ? 'CURRENT PLAN'
              : 'ACTIVATE ${selected.name.toUpperCase()} PLAN',
          onPressed: viewModel.isCurrentPlanSelected
              ? null
              : viewModel.showConfirmationMessage,
        ),
      ],
    );
  }
}
