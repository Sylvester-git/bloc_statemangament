## Bloc_statemanagement

emit acts like setstate.
state tells the current of the data.


## Observing a Cubit
When a Cubit emits a new state, a Change occurs. We can observe all changes for a given Cubit by overriding onChange, this also applies to bloc

## Error Handling
Every Cubit has an addError method which can be used to indicate that an error has occurred and an onError method to do something if an error occures, this also applies to Bloc

## Stream usage
It is always a good practice to cancel all streams and close all a cubit when not in use. This also applies to bloc.
# Note: await Future.delayed(Duration.zero) is added for this example to avoid canceling the subscription immediately.

## Bloc
Events are the input to a Bloc.They are commonly added in response to user interactions such as button presses or lifecycle events like page loads.
Bloc requires us to register event handlers via the on<Event> API, as opposed to functions in Cubit.
An event handler is responsible for converting any incoming events into zero or more outgoing states.
# Tip: 
An EventHandler has access to the added event as well as an Emitter which can be used to emit zero or more states in response to the incoming event.
we can access the current state of the bloc via the 'state' getter and 'emit(state + 1)'.

# Note: 
Since the Bloc class extends BlocBase, we have access to the current state of the bloc at any point in time via the state getter just like in Cubit.

# REMIDER: 
Blocs should never directly emit new states. Instead every state change must be output in response to an incoming event within an EventHandler.
Both blocs and cubits will ignore duplicate states. If we emit State nextState where state == nextState, then no state change will occur.

Just like we did for cubit, we can also observe all the state changes for a bloc using onChanged.
One key differentiating factor between Bloc and Cubit is that because Bloc is event-driven, we are also able to capture information about what triggered the state change.
We can do this by overriding onTransition. The change from one state to another is called a Transition.
A Transition consists of the current state, the event, and the next state.
onTransition is invoked before onChange and contains the event which triggered the change from currentState to nextState.

## context.read
context.read<T>() looks up the closest ancestor instance of type T and is functionally equivalent to BlocProvider.of<T>(context). context.read is most commonly used for retrieving a bloc instance in order to add an event within onPressed callbacks.

Note: context.read<T>() does not listen to T -- if the provided Object of type T changes, context.read will not trigger a widget rebuild.

 DO use context.read to add events in callbacks.

onPressed() {
  context.read<CounterBloc>().add(CounterIncrementPressed()),
}
Copy to clipboardErrorCopied
❌ AVOID using context.read to retrieve state within a build method.

@override
Widget build(BuildContext context) {
  final state = context.read<MyBloc>().state;
  return Text('$state');
}
The above usage is error prone because the Text widget will not be rebuilt if the state of the bloc changes.

## context.watch
Like context.read<T>(), context.watch<T>() provides the closest ancestor instance of type T, however it also listens to changes on the instance. It is functionally equivalent to BlocProvider.of<T>(context, listen: true).

If the provided Object of type T changes, context.watch will trigger a rebuild.

context.watch is only accessible within the build method of a StatelessWidget or State class.

DO use BlocBuilder instead of context.watch to explicitly scope rebuilds.
# //
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: BlocBuilder<MyBloc, MyState>(
        builder: (context, state) {
          // Whenever the state changes, only the Text is rebuilt.
          return Text(state.value);
        },
      ),
    ),
  );
}

Alternatively, use a Builder to scope rebuilds.

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) {
          // Whenever the state changes, only the Text is rebuilt.
          final state = context.watch<MyBloc>().state;
          return Text(state.value);
        },
      ),
    ),
  );

 DO use Builder and context.watch as MultiBlocBuilder.

Builder(
  builder: (context) {
    final stateA = context.watch<BlocA>().state;
    final stateB = context.watch<BlocB>().state;
    final stateC = context.watch<BlocC>().state;

    // return a Widget which depends on the state of BlocA, BlocB, and BlocC
  }
)

AVOID using context.watch when the parent widget in the build method doesn't depend on the state.

@override
Widget build(BuildContext context) {
  // Whenever the state changes, the MaterialApp is rebuilt
  // even though it is only used in the Text widget.
  final state = context.watch<MyBloc>().state;
  return MaterialApp(
    home: Scaffold(
      body: Text(state.value),
    ),
  );
}
Copy to clipboardErrorCopied
Using context.watch at the root of the build method will result in the entire widget being rebuilt when the bloc state changes.

## context.select
Just like context.watch<T>(), context.select<T, R>(R function(T value)) provides the closest ancestor instance of type T and listens to changes on T. Unlike context.watch, context.select allows you listen for changes in a smaller part of a state.

Widget build(BuildContext context) {
  final name = context.select((ProfileBloc bloc) => bloc.state.name);
  return Text(name);
}
The above will only rebuild the widget when the property name of the ProfileBloc's state changes.

✅ DO use BlocSelector instead of context.select to explicitly scope rebuilds.

Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: BlocSelector<ProfileBloc, ProfileState, String>(
        selector: (state) => state.name,
        builder: (context, name) {
          // Whenever the state.name changes, only the Text is rebuilt.
          return Text(name);
        },
      ),
    ),
  );
}
Copy to clipboardErrorCopied
Alternatively, use a Builder to scope rebuilds.

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) {
          // Whenever state.name changes, only the Text is rebuilt.
          final name = context.select((ProfileBloc bloc) => bloc.state.name);
          return Text(name);
        },
      ),
    ),
  );
}
Copy to clipboardErrorCopied
❌ AVOID using context.select when the parent widget in a build method doesn't depend on the state.

@override
Widget build(BuildContext context) {
  // Whenever the state.value changes, the MaterialApp is rebuilt
  // even though it is only used in the Text widget.
  final name = context.select((ProfileBloc bloc) => bloc.state.name);
  return MaterialApp(
    home: Scaffold(
      body: Text(name),
    ),
  );
}
Copy to clipboardErrorCopied
Using context.select at the root of the build method will result in the entire widget being rebuilt when the selection changes.
