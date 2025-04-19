import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/feature/create_pizza/blocs/create_pizaa/bloc/create_pizza_bloc.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/button_create_pizza.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/image_picker_container.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/macros_file.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/pizz_discount.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/pizza_details_section.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/ui_constants.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/widgets/veg_and_spicey_section.dart';
import 'package:pizza_repository/pizza_repository.dart';

class CreatePizza extends StatefulWidget {
  const CreatePizza({super.key});

  @override
  State<CreatePizza> createState() => _CreatePizzaState();
}

class _CreatePizzaState extends State<CreatePizza> {
  late final Pizza pizza;
  late final CreatePizzaBloc _bloc;

  @override
  void initState() {
    pizza = Pizza.empty();
    _bloc = context.read<CreatePizzaBloc>();
    super.initState();
  }

  void _handleCreatePizza() {
    if (_bloc.formKey.currentState?.validate() ?? false) {
      _updatePizzaFromForm();
      _bloc.add(CreatePizzaSubmitted(pizza));
    }
  }

  void _updatePizzaFromForm() {
    pizza.name = _bloc.nameController.text.trim();
    pizza.description = _bloc.descriptionController.text.trim();
    pizza.price = int.tryParse(_bloc.priceController.text.trim()) ?? 0;
    pizza.discount = int.tryParse(_bloc.discountController.text.trim()) ?? 0;
    pizza.micros.calories =
        int.tryParse(_bloc.caloriesController.text.trim()) ?? 0;
    pizza.micros.carbs = int.tryParse(_bloc.carbsController.text.trim()) ?? 0;
    pizza.micros.protein =
        int.tryParse(_bloc.proteinController.text.trim()) ?? 0;
    pizza.micros.fat = int.tryParse(_bloc.fatController.text.trim()) ?? 0;
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pizza created successfully!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showLoadingSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Creating pizza...'),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePizzaBloc, CreatePizzaState>(
      listener: (context, state) {
        if (state is CreatePizzaLoading) {
          _showLoadingSnackBar();
        } else if (state is CreatePizzaSuccess) {
          _showSuccessSnackBar();
        } else if (state is CreatePizzaError) {
          _showErrorSnackBar(state.message);
        }
      },
      child: Scaffold(
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              decoration: UIConstants.cardDecoration,
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _bloc.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WebImagePickerContainer(pizza: pizza),
          verticalSpace(20),
          PizzaDetailsSection(pizza: pizza),
          verticalSpace(10),
          PriceDiscountSection(pizza: pizza, bloc: _bloc),
          verticalSpace(10),
          VegSpicySection(pizza: pizza, bloc: _bloc),
          verticalSpace(10),
          MacrosSection(),
          verticalSpace(10),
          ButtonCreatePizza(
            isLoading: false,
            onPressed: _handleCreatePizza,
            text: 'Create Pizza',
            formKey: _bloc.formKey,
          ),
        ],
      ),
    );
  }
}
