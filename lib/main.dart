import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qualidade_software/api/posts_repository.dart';
import 'package:flutter_qualidade_software/extra_screen.dart';
import 'package:flutter_qualidade_software/posts_bloc/posts_bloc.dart';

import 'text_field_bloc/text_field_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          key: const Key('main_column'),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              key: Key('title_text'),
            ),
            Text(
              '$_counter',
              key: const Key('counter_text'),
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<PostsBloc>(
                        create: (context) => PostsBloc(
                          postsRepository: PostsRepository(),
                        ),
                      ),
                      BlocProvider<TextFieldBloc>(
                        create: (context) => TextFieldBloc(),
                      ),
                    ],
                    child: const ExtraScreen(),
                  ),
                ),
              ),
              child: const Text('Open'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          key: Key('increment_counter_button'),
        ),
      ),
    );
  }
}
