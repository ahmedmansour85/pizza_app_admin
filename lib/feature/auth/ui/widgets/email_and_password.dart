import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pizza_app_admin/core/theming/color_managers.dart';

import 'package:pizza_app_admin/core/widgets/app_text_form_field.dart';
import 'package:pizza_app_admin/feature/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import '../../../../core/helpers/app_regex.dart';

class EmailAndPassword extends StatefulWidget {
  final bool signinrequred;
  const EmailAndPassword({super.key, required this.signinrequred});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignInBloc>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextFormField(
            height: 20,
            width: 20,
            focusNode: _emailFocusNode,
            hintText: 'Email',
            controller: emailController,
            backgroundColor: ColorManagers.grey.withOpacity(0.1),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            height: 20,
            width: 20,
            focusNode: _passwordFocusNode,
            hintText: 'Password',
            controller: passwordController,
            isObscureText: obscurePassword,
            backgroundColor: ColorManagers.grey.withOpacity(0.1),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          widget.signinrequred
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      bloc.add(SignInRequired(
                        emailController.text,
                        passwordController.text,
                      ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        ColorManagers.onBackgroundColor),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 70)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: const Text('Sign In'),
                )
        ],
      ),
    );
  }
}
