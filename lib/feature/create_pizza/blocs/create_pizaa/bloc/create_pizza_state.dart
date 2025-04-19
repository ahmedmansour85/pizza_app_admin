part of 'create_pizza_bloc.dart';

sealed class CreatePizzaState extends Equatable {
  const CreatePizzaState();

  @override
  List<Object> get props => [];
}

final class CreatePizzaInitial extends CreatePizzaState {}

final class CreatePizzaLoading extends CreatePizzaState {}

final class CreatePizzaSuccess extends CreatePizzaState {}

final class CreatePizzaError extends CreatePizzaState {
  final String message;

  const CreatePizzaError(this.message);

  @override
  List<Object> get props => [message];
}
