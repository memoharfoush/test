import 'package:test/quiz_build.dart';
import 'package:flutter/material.dart';
import 'package:test/log_in.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/quiz.dart';
import 'package:test/questionPage.dart';
import 'package:test/questionbuild.dart';

class EditQues extends StatefulWidget {
  final queText;
  final quesMark;
  final quesId;
  final quiz_id;
  const EditQues(
      {super.key, this.queText, this.quesMark, this.quesId, this.quiz_id});

  @override
  State<EditQues> createState() => _EditQues();
}

class _EditQues extends State<EditQues> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController queText = TextEditingController();
  TextEditingController quesMark = TextEditingController();
  TextEditingController quiz_id = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    queText.text = widget.queText;
    quesMark.text = widget.quesMark;

    super.initState();
  }

  final dbHelper = DatabaseHelper.internal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('Edit Quiz :'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: queText,
                      decoration: InputDecoration(hintText: "Question name:"),
                    ),
                    TextFormField(
                      controller: quesMark,
                      decoration: InputDecoration(hintText: "Question mark:"),
                    ),
                    TextFormField(
                      controller: quiz_id,
                      decoration: InputDecoration(hintText: " id quiz:"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () async {
                        // int result = await databaseHelper.updateQuiz('''
                        // UPDATE quiz SET
                        // name = "${name.text}"
                        // WHERE quiz_id = ${widget.qId}
                        //  ''');
                        int result = await databaseHelper.updateQues(
                            "question",
                            {
                              "questext": "${queText.text}",
                              "markques": "${quesMark.text}",
                              "quiz_id": "${widget.quiz_id}"
                            },
                            "ques_id= ${widget.quesId}");
                        print("result=====");
                        print(result);
                        if (result > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => QuizBuild()),
                              (route) => false);
                        }
                      },
                      child: Text("Edit Quiz"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
