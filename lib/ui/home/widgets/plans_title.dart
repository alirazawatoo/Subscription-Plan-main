import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_text.dart';

class PlansTitle extends StatelessWidget {
  const PlansTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.h,
          width: 80.w,
          decoration: const BoxDecoration(color: Color(0xFF033C3A)),
          child: const SizedBox(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFF033C3A)),
          child: Text(
            "PLANS",
            style: kRubikText.copyWith(
                fontSize: 16.sp, color: const Color(0xFFEBEBF0)),
          ),
        ),
        Container(
          height: 1.h,
          width: 80.w,
          decoration: const BoxDecoration(color: Color(0xFF033C3A)),
          child: const SizedBox(),
        ),
      ],
    );
  }
}
