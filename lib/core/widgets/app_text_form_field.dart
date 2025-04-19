import 'package:flutter/material.dart';

import '../theming/color_managers.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final double height;
  final double width;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final List<BoxShadow>? boxShadow;

  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? hintText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String? labelText;

  const AppTextFormField({
    super.key,
    this.focusNode,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.labelStyle,
    this.hintText,
    this.isObscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.labelText,
    required this.height,
    required this.width,
    this.textAlign,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor ??
                const Color.fromARGB(255, 236, 15, 15).withOpacity(0.5),
            backgroundColor ??
                const Color.fromARGB(255, 19, 2, 2).withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: TextFormField(
        key: ValueKey(hintText),
        autofocus: false,
        textAlign: textAlign ?? TextAlign.start,
        focusNode: focusNode,
        controller: controller,
        obscureText: isObscureText,
        style: inputTextStyle ?? TextStyles.font14onbackgroundRegular,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: height, vertical: width),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorManagers.onPrimaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManagers.onBackgroundColor.withOpacity(0.5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManagers.onPrimaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          hintStyle: hintStyle ?? TextStyles.font14graysemiBold,
          labelText: labelText ?? hintText,
          labelStyle: labelStyle ??
              TextStyles.font14graysemiBold.copyWith(
                color: ColorManagers.moredarkBlue,
              ),
          suffixIcon: suffixIcon != null
              ? _AnimatedSuffixIcon(child: suffixIcon!)
              : null,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: backgroundColor,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: validator,
      ),
    );
  }
}

class _AnimatedSuffixIcon extends StatefulWidget {
  final Widget child;

  const _AnimatedSuffixIcon({required this.child});

  @override
  _AnimatedSuffixIconState createState() => _AnimatedSuffixIconState();
}

class _AnimatedSuffixIconState extends State<_AnimatedSuffixIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
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
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
