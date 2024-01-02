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

class Quizmath1 extends StatefulWidget {
  final opValue;
  final correctOp;
  final opId;
  final question_id;
  const Quizmath1(
      {super.key, this.opValue, this.correctOp, this.opId, this.question_id});

  @override
  State<Quizmath1> createState() => _Quizmath1();

  static map(Widget Function(dynamic question) param0) {}
}

class _Quizmath1 extends State<Quizmath1> {
  @override
  DatabaseHelper databaseHelper = DatabaseHelper();

  bool isLoading = true;
  List question = [];
  List option = [];
  int _currentQuestionIndex = 0;
  late PageController pc;
  final dbHelper = DatabaseHelper.internal();

  Future readD() async {
    List<Map> result = await databaseHelper.readData(
        '''SELECT quiz.name, question.questext , option.op_value FROM quiz
    JOIN question ON quiz.quiz_id=question.quiz_id
    JOIN option ON question.ques_id=option.question_id
    WHERE quiz.name='Math' AND question.ques_id IN ('1','2','3')
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
                        return Column(
                          children: [
                            Expanded(
                              child: Text(
                                "${question[i]['questext']}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text("${option[i]['op_value']}"),
                              trailing: Radio(
                                value:
                                    "${option[i + 1]['op_value']}", // Adjust value if needed
                                groupValue: selectedAnswerForQuestion(
                                    i), // Track selected answer
                                onChanged: (value) {
                                  setState(() {
                                    // Update selected answer for this question
                                    setSelectedAnswerForQuestion(
                                        i, option[i + 1]['op_value']);
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("${option[i]['op_value']}"),
                              trailing: Radio(
                                value:
                                    "${option[i + 2]['op_value']}", // Adjust value if needed
                                groupValue: selectedAnswerForQuestion(
                                    i), // Track selected answer
                                onChanged: (value) {
                                  setState(() {
                                    // Update selected answer for this question
                                    setSelectedAnswerForQuestion(
                                        i, option[i + 2]['op_value']);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

selectedAnswerForQuestion(int questionIndex) {
  //Implement logic to retrieve selected answer for the given question
}

setSelectedAnswerForQuestion(int questionIndex, int? answerIndex) {
  // Implement logic to store selected answer for the given question
}
