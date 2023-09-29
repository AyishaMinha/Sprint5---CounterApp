import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc/cubit/counter_cubit.dart';
import 'package:multi_bloc/cubit/theme_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
          // child: Container(),
        )
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: (state)? dark : light,
            home: const MyHomePage(title: 'Counter App using MultiBlocProvider'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 20),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
        FloatingActionButton(
            onPressed: BlocProvider.of<CounterCubit>(context).increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

          SizedBox(width: 20,),

          FloatingActionButton(
        onPressed: BlocProvider.of<CounterCubit>(context).decrement,
        tooltip: 'decrement',
        child: const Icon(Icons.remove),
      ),
  ],
),

          ],
        ),
      ),
      floatingActionButton:
      
       FloatingActionButton(
        onPressed: () => BlocProvider.of<ThemeCubit>(context).themeChanged(),
        tooltip: 'Change theme',
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
