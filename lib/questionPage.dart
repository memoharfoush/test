import 'package:test/questionbuild.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/question.dart';
import 'package:flutter/material.dart';
import 'package:test/quiz_build.dart';
import 'package:test/quizPage.dart';

class QuestionPag extends StatefulWidget {
  const QuestionPag({super.key});

  @override
  State<QuestionPag> createState() => _QuestionPag();
}

class _QuestionPag extends State<QuestionPag> {
  bool isLoading = true;
  List question = [];

  final dbHelper = DatabaseHelper.internal();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController questext = TextEditingController();
  TextEditingController markques = TextEditingController();
  TextEditingController quiz_id = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Page !'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: questext,
                        decoration:
                            InputDecoration(hintText: "Enter question:"),
                      ),
                      TextFormField(
                        controller: markques,
                        decoration: InputDecoration(hintText: "Enter mark"),
                      ),
                      TextFormField(
                        controller: quiz_id,
                        decoration: InputDecoration(hintText: "Enter Id quiz"),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          //   int result = await databaseHelper.readData(
                          //      "SELECT quiz.name , question.questext FROM quiz JOIN question ON quiz.quiz_id = question.quiz_id WHERE question.questext="${questext.text}" AND quiz.name ='Math' ");

                          // print('$result');
                        },
                      ),
                      Container(height: 20),
                      MaterialButton(
                          textColor: Colors.white,
                          color: Colors.pink,
                          onPressed: () async {
                            //  int result = await databaseHelper.insertQuiz(
                            //    '''
                            //  INSERT INTO question(`ques_text`,`mark_ques`,`quiz_id`)
                            //  VALUES ("${questext.text}","${markques.text}","${quiz_id.text}" )
                            // ''');
                            int result =
                                await databaseHelper.insertQues("question", {
                              "questext": "${questext.text}",
                              "markques": "${markques.text}",
                              "quiz_id": "${quiz_id.text}"
                            });
                            //   print("result=====");
                            //  print(result);
                            if (result > 0) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Questionbuild()),
                                  (route) => false);
                            }
                          },
                          child: Text('Add Question to Quiz')),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
