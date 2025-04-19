import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/theming/color_managers.dart';

class UIConstants {
  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        offset: Offset(0, 5),
      ),
    ],
  );

  static BoxDecoration macroCardDecoration = BoxDecoration(
    color: ColorManagers.onErrorColor,
    borderRadius: BorderRadius.all(Radius.circular(0)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 0,
        offset: Offset(0, 5),
      ),
    ],
  );

  static final spicyIndicatorBorder = Border.all(
    color: Colors.grey,
    width: 1,
  );

  static final spicyIndicatorSelectedBorder = Border.all(
    color: Colors.black,
    width: 3,
  );
}
