import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/ticker.dart';

import '../bloc/timer_bloc.dart';

// class TimerPage extends StatelessWidget {
//   const TimerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => TimerBloc(ticker: const Tickers()),
//       child: const TimerView(),
//     );
//   }
// }

// class TimerView extends StatelessWidget {
//   const TimerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 100.0),
//               child: Center(child: TimerText()),
//             ),
//             Action(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimerText extends StatelessWidget {
//   const TimerText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var duration = context.select((TimerBloc bloc) => bloc.state.duration);
//     var min = (duration / 60).floor().toString().padLeft(2, "0");
//     var sec = (duration % 60).floor().toString().padLeft(2, "0");
//     return Text(
//       "$min : $sec",
//       style: Theme.of(context).textTheme.headlineLarge,
//     );
//   }
// }

// class Action extends StatelessWidget {
//   const Action({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TimerBloc, TimerState>(
//       builder: (context, state) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ...switch (state) {
//               TimerInitial() => [
//                   FloatingActionButton(
//                     child: const Icon(Icons.play_arrow),
//                     onPressed: () =>
//                         context.read<TimerBloc>().add(TimerStarted(duration: state.duration)),
//                   ),
//                 ],
//               TimerRunInProgress() => [
//                   FloatingActionButton(
//                     child: const Icon(Icons.pause),
//                     onPressed: () => context.read<TimerBloc>().add(const TimerPaused()),
//                   ),
//                   FloatingActionButton(
//                     child: const Icon(Icons.replay),
//                     onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
//                   ),
//                 ],
//               TimerRunPause() => [
//                   FloatingActionButton(
//                     child: const Icon(Icons.play_arrow),
//                     onPressed: () => context.read<TimerBloc>().add(const TimerResumed()),
//                   ),
//                   FloatingActionButton(
//                     child: const Icon(Icons.replay),
//                     onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
//                   ),
//                 ],
//               TimerRunComplete() => [
//                   FloatingActionButton(
//                     child: const Icon(Icons.replay),
//                     onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
//                   ),
//                 ]
//             }
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_timer/ticker.dart';
// import 'package:flutter_timer/timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Tickers()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: const Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              Actions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final hourStr = (duration / (60 * 60)).floor().toString().padLeft(2, '0');
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$hourStr:$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerStarted(duration: state.duration)),
                  ),
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () => context.read<TimerBloc>().add(const TimerPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context.read<TimerBloc>().add(const TimerResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ]
            }
          ],
        );
      },
    );
  }
}
