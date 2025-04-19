import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/core/widgets/app_text_form_field.dart';
import 'package:pizza_app_admin/feature/create_pizza/blocs/create_pizaa/bloc/create_pizza_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaDetailsSection extends StatelessWidget {
  final Pizza pizza;
  const PizzaDetailsSection({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CreatePizzaBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          height: 20,
          width: 20,
          controller: bloc.nameController,
          hintText: 'Name Pizza',
          validator: _validateRequired,
        ),
        verticalSpace(10),
        AppTextFormField(
          height: 20,
          width: 20,
          controller: bloc.descriptionController,
          hintText: 'Description',
          validator: _validateRequired,
        ),
      ],
    );
  }

  static String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
