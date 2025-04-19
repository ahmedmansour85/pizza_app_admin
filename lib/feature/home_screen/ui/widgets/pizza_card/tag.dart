import 'package:flutter/material.dart';

// عنصر لعرض علامة (تاج) مع أيقونة ونص
class Tag extends StatelessWidget {
  // الأيقونة المراد عرضها
  final IconData icon;
  // النص المراد عرضه
  final String label;
  // لون العلامة
  final Color color;
  // تحديد ما إذا كانت العلامة كبيرة الحجم
  final bool isLarge;
  // تحديد ما إذا كانت العلامة مضغوطة الحجم
  final bool isCompact;

  const Tag({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.isLarge = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // تحديد المسافات الداخلية بناءً على الحجم
      padding: EdgeInsets.symmetric(
        horizontal: isLarge
            ? 8
            : isCompact
                ? 4
                : 6,
        vertical: isLarge
            ? 4
            : isCompact
                ? 2
                : 3,
      ),
      // تزيين الحاوية بخلفية وحدود وظل
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(isLarge
            ? 10
            : isCompact
                ? 6
                : 8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // عرض الأيقونة
          Icon(
            icon,
            size: isLarge
                ? 16
                : isCompact
                    ? 10
                    : 12,
            color: color,
          ),
          // مسافة بين الأيقونة والنص
          SizedBox(
              width: isLarge
                  ? 4
                  : isCompact
                      ? 2
                      : 3),
          // عرض النص
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: isLarge
                  ? 12
                  : isCompact
                      ? 8
                      : 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
