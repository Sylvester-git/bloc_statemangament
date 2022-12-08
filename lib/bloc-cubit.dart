// import 'package:flutter_bloc/flutter_bloc.dart';

// //////////////////////////////// CUBIT   /////////////////////////////////
// //Use of Cubbit from the bloc  package
// class Counter extends Cubit<int> {
//   //Giving it an intial value //COMPULSORY SOMETIMES
//   Counter() : super(0);
//   //emit acts like setstate.
//   //state tells the current of  the data.
//   void addition() => emit(state + 4);

//   //Observing a Cubit
//   //When a Cubit emits a new state, a Change occurs. We can observe all changes for a given Cubit by overriding onChange
//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }

//   //Error Handling
//   //Every Cubit has an addError method which can be used to indicate that an error has occurred.

//   @override
//   void onError(Object error, StackTrace stackTrace) {
//     print('$error, $stackTrace');
//     super.onError(error, stackTrace);
//   }
// }

// class cubit {
//   //Basic usage
//   void basic_usage() {
//     final counter = Counter();
//     print(counter.state);
//     counter.addition();
//     print(counter.state);
//     print('\n');
//   }

//   //Stream Usage
//   Future<void> stream_usage() async {
//     final cubit = Counter();
//     final subscription = cubit.stream.listen((event) {
//       print(cubit.state);
//     });
//     cubit.addition();
//     await Future.delayed(Duration.zero);
//     //It is always a good practice to cancel all streams and close all a cubit when not in use.
//     //Note: await Future.delayed(Duration.zero) is added for this example to avoid canceling the subscription immediately.
//     await subscription.cancel();
//     await cubit.close();
//   }

//   //Onchanged
//   void observingchanges() {
//     /**
//      * Note: A Change occurs just before the state of the Cubit is updated.
//      * A Change consists of the currentState and the nextState.
//      */
//     final result = Counter()
//       ..addition()
//       ..close();
//     print(result);
//   }
// }

// ////////////////////////////////////// BLOC //////////////////////////////////
// /// Events are the input to a Bloc. They are commonly added in response to
// /// user interactions such as button presses or lifecycle events like page loads.

// ///BASIC FORM OF A BLOC ELEMENT
// // abstract class ConterEvent {}

// // class CounterIncrementPressed extends ConterEvent {}

// // class CounterBloc extends Bloc<ConterEvent, int> {
// //   ///Just like when creating the CounterCubit,
// //   ///we must specify an initial state by passing it to the superclass via super.
// //   CounterBloc() : super(0);
// // }

// //STATE CHNAGES
// ///Bloc requires us to register event handlers via the on<Event> API, as opposed to functions in Cubit.
// ///An event handler is responsible for converting any incoming events into zero or more outgoing states.

// abstract class ConterEvent {}

// class CounterIncrementPressed extends ConterEvent {}

// class CounterBloc extends Bloc<ConterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) {
//       // handle incoming `CounterIncrementPressed` event e,g
//       emit(state + 1);
//     });
//   }

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }

//   @override
//   void onTransition(Transition<ConterEvent, int> transition) {
//     super.onTransition(transition);
//     print(transition);
//   }
// }

// ///Tip: an EventHandler has access to the added event as well as an
// ///Emitter which can be used to emit zero or more states in response to the incoming event.

// ///we can access the current state of the bloc via the 'state' getter and 'emit(state + 1)'.

// ///Note: Since the Bloc class extends BlocBase, we have access to the current state of the
// ///bloc at any point in time via the state getter just like in Cubit.

// ///REMIDER: Blocs should never directly emit new states. Instead every state change must be output in response to an incoming event within an EventHandler.
// ///Both blocs and cubits will ignore duplicate states. If we emit State nextState where state == nextState, then no state change will occur.

// class bloc {
//   //Basic usage

//   Future<void> bloc_basic() async {
//     final bloc = CounterBloc();
//     print(bloc.state);
//     bloc.add(CounterIncrementPressed());
//     await Future.delayed(Duration.zero);
//     print(bloc.state);
//     await bloc.close();
//   }

//   //Stream Usage

//   ///Just like with Cubit, a Bloc is a special type of Stream,
//   ///which means we can also subscribe to a Bloc for real-time updates to its state.

//   Future<void> stream_usage() async {
//     final bloc = CounterBloc();
//     final subscription = bloc.stream.listen((event) {
//       print(bloc.state);
//     });
//     bloc.add(CounterIncrementPressed());
//     await Future.delayed(Duration.zero);
//     await subscription.cancel();
//     await bloc.close();
//   }

//   ///Just like we did for cubit, we can also observe all the state changes for
//   ///a bloc using onChanged

//   ///One key differentiating factor between Bloc and Cubit is that because Bloc is event-driven,
//   ///we are also able to capture information about what triggered the state change.
//   ///We can do this by overriding onTransition.
//   ///The change from one state to another is called a Transition.
//   ///A Transition consists of the current state, the event, and the next state.
//   ///onTransition is invoked before onChange and contains the event which triggered the change from currentState to nextState.

// }
