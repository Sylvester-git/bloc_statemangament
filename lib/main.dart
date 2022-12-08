import 'package:bloc_statemanagement/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocprovider/counterbloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final result = cubit();
    // result.basic_usage();
    // result.stream_usage();
    // result.observingchanges();

    // final result = bloc();
    // result.bloc_basic();
    // result.stream_usage();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: BlocProvider(
            create: (context) => CounterBloc(), child: const Counterpage()));
  }
}
