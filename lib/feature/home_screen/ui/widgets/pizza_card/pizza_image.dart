import 'package:flutter/material.dart';

// عنصر لعرض صورة البيتزا مع تأثيرات بصرية
class PizzaImage extends StatelessWidget {
  // رابط الصورة
  final String imageUrl;
  // نصف قطر الزوايا المستديرة
  final double borderRadius;
  // أقصى ارتفاع للصورة
  final double maxHeight;

  const PizzaImage({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // تقليم الصورة لتكون الزوايا العلوية مستديرة
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // عرض الصورة مع تأثير التلاشي عند التحميل
            FadeInImage(
              // صورة مؤقتة تظهر أثناء تحميل الصورة الرئيسية
              placeholder:
                  const AssetImage('assets/images/pizza_placeholder.png'),
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              // مدة تأثير التلاشي
              fadeInDuration: const Duration(milliseconds: 300),
              // معالجة حالة فشل تحميل الصورة
              imageErrorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
            // إضافة تدرج لوني فوق الصورة
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
