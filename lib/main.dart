import 'package:clean_code_practice/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:clean_code_practice/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia Page'),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: TriviaPage(),
      ),
    );
  }
}

class TriviaPage extends StatelessWidget {
  TriviaPage({super.key});

  final TextEditingController triviaCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: double.maxFinite,
              child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (_, state) {
                if (state is NumberTriviaInitial) {
                  return const Center(child: Text("Start Searching"));
                }
                if (state is NumberTriviaLoading) {
                  return const Center(child: Text('Searching'));
                } else if (state is NumberTriviaFailure) {
                  return Center(child: Text(state.message));
                } else if (state is NumberTriviaLoaded) {
                  return Column(
                    children: [
                      Text(
                        state.trivia.number.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.trivia.text,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: TextFormField(
                controller: triviaCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input a number',
                ),
                onFieldSubmitted: (_) => getConcrete(context),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                child: const Text(
                  "Get Random Trivia",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => getRandom(context))
          ],
        ),
      ),
    );
  }

  getConcrete(context) {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetConcreteNumberTriviaEvent(triviaCtrl.text));
    triviaCtrl.clear();
  }

  getRandom(context) {
    triviaCtrl.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetRandomNumberTriviaEvent());
  }
}
