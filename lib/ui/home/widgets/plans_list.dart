import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/subcription_tile.dart';
import 'package:stacked/stacked.dart';

import 'activation_upgrade_button.dart';

class PlansList extends ViewModelWidget<HomeViewModel> {
  const PlansList({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: viewModel.subscriptions?.subscriptions.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              viewModel.setSelectedIndex(index);
            },
            child: SubScriptionTile(
              borderColor: viewModel.selectedIndex == index
                  ? Colors.white
                  : const Color(0xFFEBEBF0),
              width: viewModel.selectedIndex == index ? 2 : 0.1,
              icon: viewModel.getIcon(index),
              currency:
                  viewModel.subscriptions?.subscriptions[index].currency ?? '',
              duration:
                  viewModel.subscriptions?.subscriptions[index].duration ?? 0,
              features:
                  viewModel.subscriptions?.subscriptions[index].features ?? [],
              name: viewModel.subscriptions?.subscriptions[index].name ?? '',
              price: viewModel.subscriptions?.subscriptions[index].price ?? 0,
            ),
          ),
        ),
        ActivationUpgradeButton(
          title: 'ACTIVATE/UPDATE PLAN',
          onPressed: () => viewModel.showConfirmationMessage(),
        )
      ],
    );
  }
}
