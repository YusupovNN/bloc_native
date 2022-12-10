import 'package:bloc_native/domain/bloc/container_bloc.dart';
import 'package:bloc_native/domain/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            LeftBtn(),
          ],
          title: Text('Native BloC'),
        ),
        body: BodyContent(),
      ),
    );
  }
}

class LeftBtn extends StatelessWidget {
  const LeftBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SecondPage()));
      },
      icon: Icon(
        Icons.fork_left_rounded,
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: CounterBody(),
      ),
    );
  }
}

class CounterBody extends StatefulWidget {
  const CounterBody({super.key});

  @override
  State<CounterBody> createState() => _CounterBodyState();
}

class _CounterBodyState extends State<CounterBody> {
  CounterBloc bloc = CounterBloc();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
          stream: bloc.outputStateStream,
          initialData: 0,
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    bloc.inputEventSink.add(CounterEvents.incrementEvent);
                  },
                  icon: Icon(Icons.add),
                ),
                Text('${snapshot.data}'),
                IconButton(
                  onPressed: () {
                    bloc.inputEventSink.add(CounterEvents.decrementEvent);
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            );
          }),
    );
  }
}

class BodyContent extends StatefulWidget {
  const BodyContent({super.key});

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  ContainerBloc bloc = ContainerBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(),
        Center(
          child: StreamBuilder(
            stream: bloc.outputStateStream,
            initialData: Colors.blue,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 200,
                width: 200,
                color: snapshot.data,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: 'asdsadf',
              backgroundColor: Colors.red,
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.colorRedEvent);
              },
            ),
            FloatingActionButton(
              backgroundColor: Colors.green,
              heroTag: 'asdaewtewtq',
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.colorGreenEvent);
              },
            ),
            FloatingActionButton(
              heroTag: 'asdasdfwetqwe',
              backgroundColor: Colors.yellow,
              onPressed: () {
                bloc.inputEventSink.add(ContainerEvents.randColorEvent);
              },
            ),
          ],
        ),
      ],
    );
  }
}
