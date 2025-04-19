part of 'get_pizza_bloc.dart';

sealed class GetPizzaEvent extends Equatable {
  const GetPizzaEvent();

  @override
  List<Object> get props => [];
}

final class GetPizzas extends GetPizzaEvent {}
