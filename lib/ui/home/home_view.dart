import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/plans_list.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/plans_title.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/status_message.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/subscription_expiration.dart';
import 'package:flutter_stacked_starter/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getSubscriptions();
  }

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('SUBSCRIPTION PLAN'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0x33FFFFFF)),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: _content(viewModel),
          ),
        ),
      ),
    );
  }

  Widget _content(HomeViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Loading plans'),
      );
    }
    if (viewModel.subscriptions == null) {
      return StatusMessage(
        icon: Icons.cloud_off_outlined,
        title: 'Plans could not be loaded',
        message: viewModel.loadError ?? 'Something went wrong',
        actionLabel: 'Try again',
        onAction: viewModel.getSubscriptions,
      );
    }
    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SubscriptionDetails(),
          const PlansTitle(),
          if (viewModel.plans.isEmpty)
            const StatusMessage(
              icon: Icons.inventory_2_outlined,
              title: 'No plans on offer',
              message: 'There are no plans to choose from right now. '
                  'Pull down to check again.',
            )
          else
            const PlansList(),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
