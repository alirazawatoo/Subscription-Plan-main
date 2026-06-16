import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/constants.dart';
import '../../../utils/app_text.dart';
import '../../../utils/ui_helpers.dart';
import '../home_viewmodel.dart';

class SubScriptionTile extends ViewModelWidget<HomeViewModel> {
  final String name;
  final int price;
  final String currency;
  final List<String> features;
  final int duration;
  final IconData icon;
  final Color borderColor;
  final double width;
  const SubScriptionTile(
      {super.key,
      required this.icon,
      required this.name,
      required this.price,
      required this.currency,
      required this.features,
      required this.duration,
      required this.borderColor,
      required this.width});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: borderColor, width: width),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: kRubikText.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFEBEBF0)),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          "$currency$price",
                          style: kRubikText.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFEBEBF0)),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "/$duration months",
                          style: kRubikText.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFEBEBF0)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalSpaceSmall;
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: features.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: Icon(
                        Icons.check,
                        color: const Color(0xFFEBEBF0),
                        size: 10.sp,
                      ),
                    ),
                    horizontalSpaceSmall,
                    Text(
                      features[index],
                      style: kRubikText.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFEBEBF0)),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: kcSecondaryColor),
              child: Icon(
                icon,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
