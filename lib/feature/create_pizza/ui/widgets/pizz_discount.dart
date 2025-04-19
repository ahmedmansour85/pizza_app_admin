import 'package:flutter/material.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/core/widgets/app_text_form_field.dart';
import 'package:pizza_app_admin/feature/create_pizza/blocs/create_pizaa/bloc/create_pizza_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PriceDiscountSection extends StatelessWidget {
  final CreatePizzaBloc bloc;
  final Pizza pizza;
  const PriceDiscountSection(
      {super.key, required this.pizza, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormField(
            controller: bloc.priceController,
            height: 20,
            width: 20,
            hintText: 'Price',
            validator: _validatePrice,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: AppTextFormField(
            controller: bloc.discountController,
            height: 20,
            width: 20,
            hintText: 'Discount',
            validator: _validateDiscount,
            suffixIcon: Icon(Icons.percent),
          ),
        ),
      ],
    );
  }

  static String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  static String? _validateDiscount(String? value) {
    if (value != null && value.isNotEmpty) {
      if (double.tryParse(value) == null) {
        return 'Please enter a valid number';
      }
    }
    return null;
  }
}
