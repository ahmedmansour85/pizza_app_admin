import 'package:flutter/material.dart';

/// ويدجت لعرض وصف البيتزا
/// Widget to display pizza description
class Description extends StatelessWidget {
  /// وصف البيتزا
  /// Pizza description
  final String description;

  /// هل الحجم كبير؟
  /// Is the size large?
  final bool isLarge;

  /// هل الحجم مضغوط؟
  /// Is the size compact?
  final bool isCompact;

  const Description({
    super.key,
    required this.description,
    this.isLarge = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: isLarge
                ? 16
                : isCompact
                    ? 12
                    : 14,
            color: Colors.grey[700],
          ),
      maxLines: isLarge
          ? 4
          : isCompact
              ? 2
              : 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
