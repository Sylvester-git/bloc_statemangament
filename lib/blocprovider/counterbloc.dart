import 'package:flutter_bloc/flutter_bloc.dart';

abstract class counterevent {}

class CounterIncrementPressed extends counterevent {}

class CounterDecrementPressed extends counterevent {}

class CounterBloc extends Bloc<counterevent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>(
      (event, emit) => emit(state + 1),
    );

    on<CounterDecrementPressed>(
      (event, emit) => emit(state - 1),
    );
  }
}
