import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/feature/create_pizza/blocs/create_pizaa/bloc/create_pizza_bloc.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/spicey_indicator.dart';
import 'package:pizza_repository/pizza_repository.dart';

class VegSpicySection extends StatefulWidget {
  final CreatePizzaBloc bloc;
  final Pizza pizza;
  const VegSpicySection({super.key, required this.pizza, required this.bloc});

  @override
  State<VegSpicySection> createState() => _VegSpicySectionState();
}

class _VegSpicySectionState extends State<VegSpicySection> {
  bool isVeg = false;
  int selectedSpicyIndex = 1; // Default to mild (amber)

  final List<Color> spicyOptions = [Colors.amber, Colors.green, Colors.red];
  final List<int> spicyValues = [1, 2, 3]; // 1 = mild, 2 = medium, 3 = hot

  @override
  void initState() {
    super.initState();
    // Initialize selectedSpicyIndex from pizza's spicy property
    selectedSpicyIndex = widget.pizza.spicy;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox: Is Veg
        Row(
          children: [
            Checkbox(
              value: widget.pizza.isVeg,
              onChanged: (value) {
                setState(() {
                  widget.pizza.isVeg = value ?? false;
                });
              },
            ),
            const Text('Is Veg'),
          ],
        ),

        // Spicy Color Group
        Row(
          children: [
            const Text('Is Spicy'),
            horizontalSpace(10),
            ...List.generate(
                spicyOptions.length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSpicyIndex = spicyValues[index];
                            widget.pizza.spicy = selectedSpicyIndex;
                          });
                        },
                        child: SpicyIndicator(
                          color: spicyOptions[index],
                          isSelected: selectedSpicyIndex == spicyValues[index],
                        ),
                      ),
                    )),
          ],
        ),
      ],
    );
  }
}
