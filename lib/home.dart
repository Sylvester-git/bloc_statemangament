import 'package:bloc_statemanagement/blocprovider/counterbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counterpage extends StatelessWidget {
  const Counterpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Bloc state management'),
      ),
      //Use BlocBuilder or context.watch instead in order to rebuild in response to state changes.
      ///NOTE: Whenever the state changes, only the Text is rebuilt because of BlocBuilder.
      //NOTE: context.watch<>() is the same as BlocProvider.of<T>(context, listen: true).
      //context.watch is only accessible within the build method of a StatelessWidget or State class.
      ///WARNING: Using context.watch at the root of the build method will result in the entire widget being rebuilt when the bloc state changes.
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            //with extension
            //DO use context.read to add events in callbacks.
            //AVOID using context.read to retrieve state within a build method.

            onPressed: () => context.read<CounterBloc>().add(
                  CounterIncrementPressed(),
                ),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            //without extension
            onPressed: () => BlocProvider.of<CounterBloc>(context).add(
              CounterDecrementPressed(),
            ),
            tooltip: 'Decremet',
            child: const Icon(Icons.arrow_back_rounded),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
