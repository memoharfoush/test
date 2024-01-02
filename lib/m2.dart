import 'package:test/editQues.dart';
import 'package:test/question.dart';
import 'package:test/questionbuild.dart';
import 'package:test/questionPage.dart';
import 'package:test/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:test/log_in.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/quiz_build.dart';
import 'package:test/editQuiz.dart';

class Quizmath extends StatefulWidget {
  final opValue;
  final correctOp;
  final opId;
  final question_id;
  const Quizmath(
      {super.key, this.opValue, this.correctOp, this.opId, this.question_id});

  @override
  State<Quizmath> createState() => _Quizmath();

  static map(Widget Function(dynamic question) param0) {}
}

class _Quizmath extends State<Quizmath> {
  @override
  DatabaseHelper databaseHelper = DatabaseHelper();

  bool isLoading = true;
  List question = [];
  List option = [];
  int _currentQuestionIndex = 0;
  late PageController pc;
  final dbHelper = DatabaseHelper.internal();

  Future readD() async {
    List<Map> result = await databaseHelper
        .readData('''SELECT quiz.name, question.questext FROM quiz 
    JOIN question ON quiz.quiz_id=question.quiz_id
      WHERE quiz.name='Math' 
      ''');
    question.addAll(result);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  Future readD1() async {
    List<Map> result = await databaseHelper
        .readData('''SELECT question.questext, option.op_value FROM question 
    JOIN option ON question.ques_id=option.question_id
      WHERE question.ques_id='1' 
      ''');
    option.addAll(result);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readD();
    readD1();
    pc = new PageController(initialPage: 0);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('Please Solve quiz :'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => QuizPage()));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: Text("Loadig..."))
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Container(
                    height: 35,
                    width: 300,
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.pink)),
                    child: PageView.builder(
                      controller: pc,
                      itemCount: question.length,
                      itemBuilder: (context, i) {
                        return Text("${question[i]['questext']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ));
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: option.length, // Adjust based on options list
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(option[index]['op_value']),
                          value: index, // Adjust value if needed
                          groupValue: selectedAnswerForQuestion(
                              1), // Track selected answer
                          onChanged: (value) {
                            setState(() {
                              question ==
                                  1; // Update selected answer for this question
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                pc.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Text('Previous'),
            ),
            TextButton(
              onPressed: () {
                pc.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  selectedAnswerForQuestion(int questionIndex) {
    //Implement logic to retrieve selected answer for the given question
  }

  setSelectedAnswerForQuestion(int questionIndex, int? answerIndex) {
    // Implement logic to store selected answer for the given question
  }
}
