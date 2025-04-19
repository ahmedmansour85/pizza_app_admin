import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/core/theming/color_managers.dart';
import 'package:pizza_app_admin/core/theming/styles.dart';
import 'package:pizza_app_admin/core/widgets/app_text_form_field.dart';

class MacroCard extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;

  const MacroCard(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.red),
            verticalSpace(10),
            SizedBox(
              width: 40,
              height: 27,
              child: AppTextFormField(
                controller: controller,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
                height: 0,
                width: 10,
                textAlign: TextAlign.center,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: ColorManagers.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: ColorManagers.blue),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
            ),
            verticalSpace(10),
            Text(
                hintText == 'Calories'
                    ? '$hintText kcal'
                    : hintText == 'Protein'
                        ? '$hintText g'
                        : hintText == 'Fat'
                            ? '$hintText g'
                            : '$hintText g',
                style: TextStyles.font14graysemiBold),
          ],
        ),
      ),
    );
  }
}
