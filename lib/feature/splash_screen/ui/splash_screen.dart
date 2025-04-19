import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/core/blocs/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // تأخير التوجيه للتأكد من أن الواجهة جاهزة وفعالة
          Future.microtask(() {
            if (!mounted) return;

            if (state.status == AuthStatus.authenticated) {
              context.go('/home');
            } else if (state.status == AuthStatus.unauthenticated) {
              context.go('/login');
            }
          });
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
