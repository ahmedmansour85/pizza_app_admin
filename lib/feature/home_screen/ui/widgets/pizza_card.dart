import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'pizza_card/pizza_image.dart';
import 'pizza_card/title_and_price.dart';
import 'pizza_card/description.dart';
import 'pizza_card/tags_and_actions.dart';

/// نقاط التوقف للتصميم المتجاوب
/// هذه القيم تحدد متى يتغير حجم البطاقة بناءً على عرض الشاشة
class PizzaCardBreakpoints {
  static const double extraLarge = 1200; // عرض كبير جداً
  static const double large = 900; // عرض كبير
  static const double medium = 600; // عرض متوسط
  static const double small = 400; // عرض صغير
}

/// مزيج (mixin) للتعامل مع حسابات التصميم المتجاوب
/// يحتوي على جميع الدوال المساعدة لتحديد الأبعاد والمسافات
mixin PizzaCardLayoutMixin {
  /// تحقق مما إذا كان العرض كبير جداً
  bool isExtraLarge(double width) => width > PizzaCardBreakpoints.extraLarge;

  /// تحقق مما إذا كان العرض كبير
  bool isLarge(double width) => width > PizzaCardBreakpoints.large;

  /// تحقق مما إذا كان العرض متوسط
  bool isMedium(double width) => width > PizzaCardBreakpoints.medium;

  /// تحقق مما إذا كان العرض صغير
  bool isSmall(double width) => width > PizzaCardBreakpoints.small;

  /// حساب نصف قطر الزوايا بناءً على عرض الشاشة
  double getBorderRadius(double baseRadius, double width) {
    if (isExtraLarge(width)) return baseRadius * 1.5;
    if (isLarge(width)) return baseRadius * 1.2;
    if (isMedium(width)) return baseRadius;
    if (isSmall(width)) return baseRadius * 0.8;
    return baseRadius * 0.6;
  }

  /// حساب الحد الأدنى للارتفاع بناءً على عرض الشاشة
  double getMinHeight(double width) {
    if (isExtraLarge(width)) return 450;
    if (isLarge(width)) return 400;
    if (isMedium(width)) return 350;
    if (isSmall(width)) return 300;
    return 280;
  }

  /// حساب المسافات الداخلية (padding) بناءً على عرض الشاشة
  EdgeInsets getPadding(double width) {
    if (isExtraLarge(width)) return const EdgeInsets.all(24);
    if (isLarge(width)) return const EdgeInsets.all(20);
    if (isMedium(width)) return const EdgeInsets.all(16);
    if (isSmall(width)) return const EdgeInsets.all(12);
    return const EdgeInsets.all(8);
  }

  /// حساب ارتفاع الصورة بناءً على عرض الشاشة
  double getImageHeight(double width) {
    if (isExtraLarge(width)) return 300;
    if (isLarge(width)) return 250;
    if (isMedium(width)) return 200;
    if (isSmall(width)) return 180;
    return 140;
  }
}

/// بطاقة عرض البيتزا
///
/// بطاقة حديثة ومكبرة تعرض معلومات البيتزا بدون تمرير أو حركة تكبير
/// تعرض صورة البيتزا بعرض كامل، الاسم، السعر، الوصف، والعلامات
/// (نباتي، حار، خصم) بتصميم متجاوب
class PizzaCard extends StatelessWidget with PizzaCardLayoutMixin {
  final Pizza pizza; // بيانات البيتزا
  final VoidCallback? onTap; // دالة عند النقر
  final VoidCallback? onEdit; // دالة عند التعديل
  final VoidCallback? onDelete; // دالة عند الحذف
  final double elevation; // ارتفاع الظل
  final double borderRadius; // نصف قطر الزوايا

  const PizzaCard({
    super.key,
    required this.pizza,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.elevation = 6,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardBorderRadius = getBorderRadius(borderRadius, width);
        final minHeight = getMinHeight(width);

        return Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardBorderRadius),
          ),
          child: Container(
            constraints: BoxConstraints(minHeight: minHeight),
            decoration: _buildCardDecoration(cardBorderRadius),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(cardBorderRadius),
              child: _buildContent(width),
            ),
          ),
        );
      },
    );
  }

  /// بناء تنسيق البطاقة
  /// يحتوي على التدرج اللوني والظل وزوايا التقريب
  BoxDecoration _buildCardDecoration(double borderRadius) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// بناء محتوى البطاقة
  /// يعرض صورة البيتزا، العنوان، السعر، الوصف، والعلامات
  Widget _buildContent(double width) {
    final padding = getPadding(width);
    final imageHeight = getImageHeight(width);
    final isLargeLayout = isLarge(width);
    final isCompactLayout = !isSmall(width);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PizzaImage(
          imageUrl: pizza.picture,
          borderRadius: getBorderRadius(borderRadius, width),
          maxHeight: imageHeight,
        ),
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleAndPrice(
                name: pizza.name,
                price: pizza.price.toDouble(),
                isLarge: isLargeLayout,
                isCompact: isCompactLayout,
              ),
              SizedBox(height: isLargeLayout ? 16 : 8),
              Flexible(
                child: Description(
                  description: pizza.description,
                  isLarge: isLargeLayout,
                  isCompact: isCompactLayout,
                ),
              ),
              SizedBox(height: isLargeLayout ? 20 : 12),
              TagsAndActions(
                isVeg: pizza.isVeg,
                spicy: pizza.spicy,
                discount: pizza.discount.toDouble(),
                onEdit: onEdit,
                onDelete: onDelete,
                isLarge: isLargeLayout,
                isCompact: isCompactLayout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
