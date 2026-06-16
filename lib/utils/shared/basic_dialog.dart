import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/enums/basic_dialog_status.dart';
import 'package:flutter_stacked_starter/utils/app_text.dart';
import 'package:flutter_stacked_starter/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _BasicDialogContent(request: request, completer: completer),
    );
  }
}

class _BasicDialogContent extends StatelessWidget {
  const _BasicDialogContent({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidthPercentage(context, percentage: 0.07),
          ),
          padding: const EdgeInsets.only(
            top: 20,
            left: 12,
            right: 12,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              Text(
                request.title ?? '',
                textAlign: TextAlign.center,
                style: kRubikText.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: kHeadingThree,
                ),
              ),
              verticalSpaceSmall,
              Text(
                request.description ?? '',
                textAlign: TextAlign.center,
                style: kRubikText.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  letterSpacing: 0.10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        request.secondaryButtonTitle!,
                        style: kRubikText.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: () => completer(DialogResponse(confirmed: true)),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      request.mainButtonTitle ?? '',
                      style: kRubikText.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: -24,
            child: CircleAvatar(
              minRadius: 12,
              maxRadius: 22,
              backgroundColor: _getStatusColor(request.data),
              child: Icon(
                _getStatusIcon(request.data),
                size: 22,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}

Color _getStatusColor(dynamic customData) {
  switch (customData) {
    case BasicDialogStatus.error:
      return kcPrimaryColor;
    case BasicDialogStatus.warning:
      return Colors.orange;
    default:
      return Colors.green;
  }
}

IconData _getStatusIcon(dynamic regionDialogStatus) {
  if (regionDialogStatus is BasicDialogStatus) {
    switch (regionDialogStatus) {
      case BasicDialogStatus.error:
        return Icons.close;
      case BasicDialogStatus.warning:
        return Icons.warning_amber;
      default:
        return Icons.check;
    }
  } else {
    return Icons.check;
  }
}
