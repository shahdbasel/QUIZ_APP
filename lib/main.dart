import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int questionIndex = 0;
  bool showscore = false;
  int score = 0;
  String? selectedanswer;
  List<Map<String, dynamic>> qustionWithAnswers = [
    {
      'question': 'What is your favorite color?',
      'answers': ['Red', 'Blue', 'Pink', 'Black'],
      'correctAnswer': 'Pink',
      'icons': [Icons.favorite, Icons.ac_unit, Icons.local_florist, Icons.brightness_3],
    },
    {
      'question': 'What is your favorite animal?',
      'answers': ['lion', 'dog', 'cat', 'bee'],
      'correctAnswer': 'cat',
      'icons': [Icons.pets, Icons.pets, Icons.pets, Icons.bug_report],
    },
    {
      'question': 'What is your favorite food?',
      'answers': ['pizza', 'pasta', 'burger', 'sandwich'],
      'correctAnswer': 'pizza',
      'icons': [Icons.local_pizza, Icons.restaurant, Icons.fastfood, Icons.restaurant],
    },
    {
      'question': 'What is your favorite country?',
      'answers': ['Palestine', 'Egypt', 'Jordan', 'Lebanon'],
      'correctAnswer': 'Palestine',
      'icons': [Icons.flag, Icons.flag, Icons.flag, Icons.flag],
    },
  ];

  @override
  Widget build(BuildContext context) {
    double progress = (questionIndex +1 ) / qustionWithAnswers.length;
    double scoreProgress = score / qustionWithAnswers.length;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: !showscore
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              'Step  ${(questionIndex +1)} of ${(qustionWithAnswers.length)}  ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey[300],
                                color: Colors.blue,
                                minHeight: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        qustionWithAnswers[questionIndex]['question'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 60),
                      Text(
                        'Answer and get points!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        children: (qustionWithAnswers[questionIndex]['answers']
                                as List<String>)
                            .asMap()
                            .entries
                            .map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedanswer = entry.value;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: entry.value == selectedanswer
                                          ? Colors.green
                                          : null,
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          qustionWithAnswers[questionIndex]
                                              ['icons'][entry.key],
                                          color: entry.value == selectedanswer
                                              ? Colors.white
                                              : null,
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          entry.value,
                                          style: TextStyle(
                                            color: entry.value == selectedanswer
                                                ? Colors.white
                                                : null,
                                            fontWeight:
                                                entry.value == selectedanswer
                                                    ? FontWeight.bold
                                                    : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedanswer != null) {
                              if (selectedanswer ==
                                  qustionWithAnswers[questionIndex]
                                      ['correctAnswer']) {
                                setState(() {
                                  score++;
                                });
                              }

                              if (questionIndex <
                                  qustionWithAnswers.length - 1) {
                                setState(() {
                                  questionIndex++;
                                  selectedanswer = null;
                                });
                              } else {
                                setState(() {
                                  showscore = true;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select an answer first!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Next'),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Quiz Completed!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: scoreProgress,
                              backgroundColor: Colors.grey[300],
                              color: Colors.green,
                              strokeWidth: 15,
                            ),
                          ),
                          Text(
                            '${(scoreProgress * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Score: $score/${qustionWithAnswers.length}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Correct Answers:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: qustionWithAnswers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                qustionWithAnswers[index]['question'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                qustionWithAnswers[index]['correctAnswer'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            questionIndex = 0;
                            score = 0;
                            showscore = false;
                            selectedanswer = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Reset!'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
