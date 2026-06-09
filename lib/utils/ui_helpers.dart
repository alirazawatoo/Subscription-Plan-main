import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Horizontal Spacing
Widget horizontalSpaceTiny = SizedBox(width: 5.0.w);
Widget horizontalSpaceSmall = SizedBox(width: 10.0.w);
Widget horizontalSpaceRegular = SizedBox(width: 18.0.w);
Widget horizontalSpaceMedium = SizedBox(width: 25.0.w);
Widget horizontalSpaceLarge = SizedBox(width: 50.0.w);

// Vertical Spacing
Widget verticalSpaceTiny = SizedBox(height: 5.0.h);
Widget verticalSpaceSmall = SizedBox(height: 10.0.h);
Widget verticalSpaceRegular = SizedBox(height: 18.0.h);
Widget verticalSpaceMedium = SizedBox(height: 25.0.h);
Widget verticalSpaceLarge = SizedBox(height: 50.0.h);

// Screen Size Helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
