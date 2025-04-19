import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'get_pizza_event.dart';
part 'get_pizza_state.dart';

class GetPizzaBloc extends Bloc<GetPizzaEvent, GetPizzaState> {
  final PizzaRepo pizzaRepository;

  GetPizzaBloc({required this.pizzaRepository}) : super(GetPizzaInitial()) {
    on<GetPizzas>((event, emit) async {
      emit(GetPizzaLoading());
      try {
        final pizzas = await pizzaRepository.getPizzas();
        emit(GetPizzaSuccess(pizzas));
      } catch (e) {
        emit(GetPizzaError(e.toString()));
      }
    });
  }
}
