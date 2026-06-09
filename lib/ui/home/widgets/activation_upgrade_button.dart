import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_text.dart';

class ActivationUpgradeButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const ActivationUpgradeButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 15.h),
        height: 40.h,
        width: 250.w,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF00B4AF))),
            onPressed: onPressed,
            child: Text(
              title,
              style: kRubikText.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}
