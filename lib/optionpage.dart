import 'package:test/optionbuild.dart';
import 'package:test/questionbuild.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/question.dart';
import 'package:flutter/material.dart';
import 'package:test/quiz_build.dart';
import 'package:test/quizPage.dart';

class OptionPag extends StatefulWidget {
  const OptionPag({super.key});

  @override
  State<OptionPag> createState() => _OptionPag();
}

class _OptionPag extends State<OptionPag> {
  bool isLoading = true;
  List option = [];

  final dbHelper = DatabaseHelper.internal();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController optValue = TextEditingController();
  TextEditingController correctOpt = TextEditingController();
  TextEditingController question_id = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('options page !'),
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
                        controller: optValue,
                        decoration: InputDecoration(hintText: "Enter options:"),
                      ),
                      TextFormField(
                        controller: correctOpt,
                        decoration:
                            InputDecoration(hintText: "Enter correct option"),
                      ),
                      TextFormField(
                        controller: question_id,
                        decoration: InputDecoration(hintText: "question_id"),
                      ),
                      //  MaterialButton(
                      //  onPressed: () async {
                      //     int result = await databaseHelper.readData(
                      //        "SELECT quiz.ques_text FROM quiz JOIN question ON quiz.quiz_id = question.quiz_id WHERE question_text=' what 1+1' AND quiz.name = 'Maths' ");

                      //   print('$result');
                      // },
                      // ),
                      Container(height: 20),
                      MaterialButton(
                          textColor: Colors.white,
                          color: Colors.pink,
                          onPressed: () async {
                            // int result = await databaseHelper.insertQues('''
                            //   INSERT INTO question(`ques_text`,`mark_ques`,)
                            //   VALUES ("${ques_text.text}","${mark_ques.text}", )
                            //   ''');
                            int result =
                                await databaseHelper.insertO("option", {
                              "op_value": "${optValue.text}",
                              "correct_option": "${correctOpt.text}",
                              "question_id": "${question_id.text}",
                            });
                            //   print("result=====");
                            //  print(result);
                            if (result > 0) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Optionbuild()),
                                  (route) => false);
                            }
                          },
                          child: Text('Add option to Question')),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
