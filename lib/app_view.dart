import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app_admin/core/blocs/auth/auth_bloc.dart';
import 'package:pizza_app_admin/my_app_view.dart';
import 'package:user_repository/user_repository.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthBloc(userRepository: FirebaseUserRepo()),
      child: const MyAppView(),
    );
  }
}
