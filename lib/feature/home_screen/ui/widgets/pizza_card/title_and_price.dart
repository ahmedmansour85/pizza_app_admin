import 'package:flutter/material.dart';

/// ويدجت لعرض عنوان البيتزا وسعرها
/// Widget to display pizza title and price
class TitleAndPrice extends StatelessWidget {
  /// اسم البيتزا
  /// Pizza name
  final String name;

  /// سعر البيتزا
  /// Pizza price
  final double price;

  /// هل الحجم كبير؟
  /// Is the size large?
  final bool isLarge;

  /// هل الحجم مضغوط؟
  /// Is the size compact?
  final bool isCompact;

  const TitleAndPrice({
    super.key,
    required this.name,
    required this.price,
    this.isLarge = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isLarge
                      ? 26
                      : isCompact
                          ? 16
                          : 20,
                  color: Colors.black87,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: isLarge
                    ? 26
                    : isCompact
                        ? 16
                        : 20,
              ),
        ),
      ],
    );
  }
}
