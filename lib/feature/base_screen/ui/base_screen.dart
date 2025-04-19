import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/core/helpers/spacing.dart';
import 'package:pizza_app_admin/core/theming/color_managers.dart';
import 'package:pizza_app_admin/core/theming/styles.dart';
import 'package:pizza_app_admin/feature/auth/blocs/sing_in_bloc/sign_in_bloc.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  const BaseScreen({super.key, required this.child});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          html.window.location.reload();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              color: ColorManagers.onErrorColor.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.go('/home');
                        },
                        child: Text('Pizza App',
                            style: TextStyles.font20BluekBold)),
                    horizontalSpace(10),
                    InkWell(
                        onTap: () {
                          context.go('/create-pizza');
                        },
                        child: Text('Create Pizza',
                            style: TextStyles.font15DarkBlueMedium)),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(SignOutRequired());
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: widget.child)
          ],
        ),
      ),
    );
  }
}
