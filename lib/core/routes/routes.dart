import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/feature/home_screen/blocs/bloc/get_pizza_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pizza_app_admin/core/blocs/auth/auth_bloc.dart';
import 'package:pizza_app_admin/feature/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app_admin/feature/auth/ui/login_screen.dart';
import 'package:pizza_app_admin/feature/base_screen/ui/base_screen.dart';
import 'package:pizza_app_admin/feature/create_pizza/blocs/create_pizaa/bloc/create_pizza_bloc.dart';
import 'package:pizza_app_admin/feature/create_pizza/ui/create_pizza.dart';
import 'package:pizza_app_admin/feature/home_screen/ui/home_screen.dart';
import 'package:pizza_app_admin/feature/splash_screen/ui/splash_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

GoRouter router(AuthBloc authBloc) {
  return GoRouter(
      navigatorKey: _navKey,
      initialLocation: '/',
      redirect: (context, state) {
        if (authBloc.state.status == AuthStatus.unknown) {
          return '/';
        }
        return null;
      },
      routes: [
        ShellRoute(
            navigatorKey: _shellKey,
            builder: (context, state, child) {
              if (state.fullPath == '/' || state.fullPath == '/login') {
                return child;
              } else {
                return BlocProvider<SignInBloc>(
                  create: (context) =>
                      SignInBloc(context.read<AuthBloc>().userRepository),
                  child: BaseScreen(
                    child: child,
                  ),
                );
              }
            },
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => BlocProvider<AuthBloc>.value(
                    value: BlocProvider.of<AuthBloc>(context),
                    child: const SplashScreen()),
              ),
              GoRoute(
                path: '/login',
                builder: (context, state) => BlocProvider<AuthBloc>.value(
                  value: BlocProvider.of<AuthBloc>(context),
                  child: BlocProvider<SignInBloc>(
                    create: (context) =>
                        SignInBloc(context.read<AuthBloc>().userRepository),
                    child: SignInScreen(),
                  ),
                ),
              ),
              GoRoute(
                path: '/home',
                builder: (context, state) => MultiProvider(
                  providers: [
                    Provider<PizzaRepo>(
                      create: (_) => FirebasePizzaRepo(),
                    ),
                    BlocProvider<GetPizzaBloc>(
                      create: (context) => GetPizzaBloc(
                        pizzaRepository: context.read<PizzaRepo>(),
                      ),
                    ),
                  ],
                  child: const HomeScreen(),
                ),
              ),
              GoRoute(
                path: '/create-pizza',
                builder: (context, state) => MultiProvider(
                  providers: [
                    Provider<PizzaRepo>(
                      create: (_) => FirebasePizzaRepo(),
                    ),
                    BlocProvider(
                      create: (context) => CreatePizzaBloc(
                          pizzaRepository: context.read<PizzaRepo>()),
                    ),
                  ],
                  child: CreatePizza(),
                ),
              ),
            ])
      ]);
}
