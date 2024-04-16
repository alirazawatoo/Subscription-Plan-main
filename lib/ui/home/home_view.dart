import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/ui/home/home_viewmodel.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/plans_list.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/plans_title.dart';
import 'package:flutter_stacked_starter/ui/home/widgets/subscription_expiration.dart';
import 'package:flutter_stacked_starter/utils/app_text.dart';
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
      backgroundColor: kcPrimaryColor,
      appBar: AppBar(
        elevation: 0.5,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.white,
              height: 0.1.h,
            )),
        backgroundColor: kcPrimaryColor,
        leading: InkWell(
            onTap: () => viewModel.back,
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: Colors.white,
            )),
        title: Text(
          'SUBSCRIPTION PLAN',
          style: kRubikText.copyWith(
            fontSize: 17.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView(
                padding: EdgeInsets.only(bottom: 20.h),
                children: const [
                  SubscriptionDetails(),
                  PlansTitle(),
                  PlansList(),
                ],
              ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
