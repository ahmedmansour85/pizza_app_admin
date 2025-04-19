import 'package:flutter/material.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/ui_constants.dart';

class SpicyIndicator extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const SpicyIndicator({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected
            ? UIConstants.spicyIndicatorSelectedBorder
            : UIConstants.spicyIndicatorBorder,
      ),
    );
  }
}
