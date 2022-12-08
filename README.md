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