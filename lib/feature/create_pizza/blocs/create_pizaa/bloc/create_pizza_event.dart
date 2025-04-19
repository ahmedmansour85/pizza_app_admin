part of 'create_pizza_bloc.dart';

sealed class CreatePizzaEvent extends Equatable {
  const CreatePizzaEvent();

  @override
  List<Object> get props => [];
}

final class CreatePizzaSubmitted extends CreatePizzaEvent {
  final Pizza pizza;

  const CreatePizzaSubmitted(this.pizza);

  @override
  List<Object> get props => [pizza];
}
