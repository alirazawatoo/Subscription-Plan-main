import 'package:flutter/material.dart';

/// Full-width call to action under the plan list; disabled when [onPressed]
/// is null, e.g. while the current plan is selected.
class ActivationUpgradeButton extends StatelessWidget {
  const ActivationUpgradeButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed, child: Text(title)),
      ),
    );
  }
}
