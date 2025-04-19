import 'package:flutter/material.dart';
import 'tag.dart';
import 'animated_icon_button.dart';

/// ويدجت لعرض علامات البيتزا (نباتي، حار، خصم) وأزرار الإجراءات
/// Widget to display pizza tags (veg, spicy, discount) and action buttons
class TagsAndActions extends StatelessWidget {
  /// هل البيتزا نباتية؟
  /// Is the pizza vegetarian?
  final bool isVeg;

  /// مستوى الحرارة (1-3)
  /// Spice level (1-3)
  final int spicy;

  /// نسبة الخصم
  /// Discount percentage
  final double discount;

  /// دالة تعديل البيتزا
  /// Edit pizza callback
  final VoidCallback? onEdit;

  /// دالة حذف البيتزا
  /// Delete pizza callback
  final VoidCallback? onDelete;

  /// هل الحجم كبير؟
  /// Is the size large?
  final bool isLarge;

  /// هل الحجم مضغوط؟
  /// Is the size compact?
  final bool isCompact;

  const TagsAndActions({
    super.key,
    required this.isVeg,
    required this.spicy,
    required this.discount,
    this.onEdit,
    this.onDelete,
    this.isLarge = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: isCompact ? 4 : 6,
          children: [
            if (isVeg)
              Tag(
                icon: Icons.eco,
                label: 'Veg',
                color: Colors.green,
                isLarge: isLarge,
                isCompact: isCompact,
              ),
            Tag(
              icon: Icons.local_fire_department,
              label: _getSpicyText(spicy),
              color: _getSpicyColor(spicy),
              isLarge: isLarge,
              isCompact: isCompact,
            ),
            if (discount > 0)
              Tag(
                icon: Icons.discount,
                label: '${discount.round()}% OFF',
                color: Colors.orange,
                isLarge: isLarge,
                isCompact: isCompact,
              ),
          ],
        ),
        Row(
          children: [
            if (onEdit != null)
              AnimatedIconButton(
                icon: Icons.edit,
                color: Colors.blue,
                onPressed: onEdit!,
                tooltip: 'Edit Pizza',
                isLarge: isLarge,
                isCompact: isCompact,
              ),
            if (onDelete != null)
              AnimatedIconButton(
                icon: Icons.delete,
                color: Colors.red,
                onPressed: onDelete!,
                tooltip: 'Delete Pizza',
                isLarge: isLarge,
                isCompact: isCompact,
              ),
          ],
        ),
      ],
    );
  }

  /// إرجاع لون مناسب لمستوى الحرارة
  /// Returns appropriate color for spice level
  Color _getSpicyColor(int spicy) {
    switch (spicy) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// إرجاع نص مناسب لمستوى الحرارة
  /// Returns appropriate text for spice level
  String _getSpicyText(int spicy) {
    switch (spicy) {
      case 1:
        return 'Mild';
      case 2:
        return 'Medium';
      case 3:
        return 'Hot';
      default:
        return 'None';
    }
  }
}
