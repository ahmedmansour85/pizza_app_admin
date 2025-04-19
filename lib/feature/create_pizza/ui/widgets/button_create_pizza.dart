import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/theming/color_managers.dart';

class ButtonCreatePizza extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  const ButtonCreatePizza(
      {super.key,
      required this.isLoading,
      required this.onPressed,
      required this.text,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorManagers.onBackgroundColor,
              ),
            )
          : ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onPressed();
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(ColorManagers.onBackgroundColor),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                elevation: WidgetStateProperty.all(2),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20)),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
