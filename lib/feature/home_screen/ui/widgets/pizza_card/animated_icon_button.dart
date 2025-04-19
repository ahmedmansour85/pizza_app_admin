import 'package:flutter/material.dart';

// زر أيقونة متحرك مع تأثيرات حركية عند النقر
class AnimatedIconButton extends StatefulWidget {
  // الأيقونة المراد عرضها
  final IconData icon;
  // لون الأيقونة
  final Color color;
  // الدالة التي يتم تنفيذها عند النقر على الزر
  final VoidCallback onPressed;
  // نص التلميح الذي يظهر عند تمرير المؤشر فوق الزر
  final String tooltip;
  // تحديد ما إذا كان الزر كبير الحجم
  final bool isLarge;
  // تحديد ما إذا كان الزر مضغوط الحجم
  final bool isCompact;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.tooltip,
    this.isLarge = false,
    this.isCompact = false,
  });

  @override
  AnimatedIconButtonState createState() => AnimatedIconButtonState();
}

class AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  // المتحكم في الحركة
  late AnimationController _controller;
  // حركة التحجيم (التصغير والتكبير)
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // تهيئة المتحكم في الحركة مع مدة 150 مللي ثانية
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    // تهيئة حركة التحجيم من الحجم الطبيعي (1.0) إلى الحجم المصغر (0.9)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        // عند الضغط على الزر، يتم تشغيل حركة التصغير
        onTapDown: (_) => _controller.forward(),
        // عند رفع الإصبع، يتم عكس الحركة وتنفيذ الدالة المحددة
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        // عند إلغاء النقر، يتم عكس الحركة
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Icon(
            widget.icon,
            // تحديد حجم الأيقونة بناءً على الخيارات المحددة
            size: widget.isLarge
                ? 24
                : widget.isCompact
                    ? 16
                    : 20,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
