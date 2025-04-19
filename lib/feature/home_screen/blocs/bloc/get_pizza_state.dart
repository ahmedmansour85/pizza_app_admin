part of 'get_pizza_bloc.dart';

sealed class GetPizzaState extends Equatable {
  const GetPizzaState();

  @override
  List<Object> get props => [];
}

final class GetPizzaInitial extends GetPizzaState {}

final class GetPizzaLoading extends GetPizzaState {}

final class GetPizzaSuccess extends GetPizzaState {
  final List<Pizza> pizzas;

  const GetPizzaSuccess(this.pizzas);

  @override
  List<Object> get props => [pizzas];
}

final class GetPizzaError extends GetPizzaState {
  final String message;

  const GetPizzaError(this.message);

  @override
  List<Object> get props => [message];
}
