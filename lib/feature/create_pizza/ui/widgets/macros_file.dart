import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/macro_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MacrosSection extends StatelessWidget {
  const MacrosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final fatController = TextEditingController();
    final carbsController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Macros'),
        verticalSpace(10),
        Row(
          children: [
            MacroCard(
              controller: carbsController,
              icon: FontAwesomeIcons.breadSlice,
              hintText: 'Carbs',
            ),
            horizontalSpace(10),
            MacroCard(
              controller: caloriesController,
              icon: FontAwesomeIcons.fire,
              hintText: 'Calories',
            ),
            horizontalSpace(10),
            MacroCard(
              controller: proteinController,
              icon: FontAwesomeIcons.dumbbell,
              hintText: 'Protein',
            ),
            horizontalSpace(10),
            MacroCard(
              controller: fatController,
              icon: FontAwesomeIcons.oilWell,
              hintText: 'Fat',
            ),
          ],
        ),
      ],
    );
  }
}
