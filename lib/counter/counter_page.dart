// responsible for providing counter cubit to counter view

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitch_koko_bloc_learning/counter/counter_cubit.dart';
import 'package:mitch_koko_bloc_learning/counter/counter_view.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(0),
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state == 10) {
            showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(content: Text("10 Reached!")),
            );
          }
        },
        child: CounterView(),
      ),
    );
  }
}
