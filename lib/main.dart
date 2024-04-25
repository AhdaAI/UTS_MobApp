import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UTS'),
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
  Color backgroundColor = Colors.white;
  int questionIndex = 0;
  List<String> questions = [
    'Apakah nama kamu Ahda Akmalul Ilmi?',
    'Apakah NIM kamu 1101202381?'
  ];
  List<bool> userAnswers = [];
  List<Icon> userAnswersIcons = [];

  int correctAnswers = 0;

  void handleAnswer(bool isCorrect) {
    setState(() {
      backgroundColor = isCorrect ? Colors.green : Colors.red;
      if (isCorrect) {
        correctAnswers++;
      }

      userAnswersIcons.add(isCorrect
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.close_rounded,
              color: Colors.red,
            ));

      userAnswers.add(isCorrect);

      if (userAnswers.length != questions.length) {
        questionIndex++;
      }
    });
  }

  void reset() {
    setState(() {
      backgroundColor = Colors.white;
      questionIndex = 0;
      correctAnswers = 0;
      userAnswers.clear();
      userAnswersIcons.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
                visible: userAnswers.length != questions.length,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        questions[questionIndex],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              handleAnswer(true);
                            },
                            child: const Text('Ya')),
                        ElevatedButton(
                            onPressed: () {
                              handleAnswer(false);
                            },
                            child: const Text('Tidak')),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: userAnswersIcons,
                )),
            Visibility(
                visible: userAnswers.length == questions.length,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Thank You!',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                )),
          ],
        ),
      ),
      // backgroundColor: backgroundColor
    );
  }
}
