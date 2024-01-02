import 'package:test/quiz_build.dart';
import 'package:flutter/material.dart';
import 'package:test/log_in.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quiz.dart';
import 'package:sqflite/sqflite.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPage();
}

class _QuizPage extends State<QuizPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController quiz_id = TextEditingController();
  TextEditingController name = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  final dbHelper = DatabaseHelper.internal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('Please choice your quiz :'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(hintText: "Quiz name:"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () async {
                        int result = await databaseHelper.insertQuiz('''
                          INSERT INTO quiz(name)
                          VALUES ("${name.text}")''');
                        print("result=====");
                        print(result);
                        if (result > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => QuizBuild()),
                              (route) => false);
                        }
                      },
                      child: Text("Add Quiz"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () async {
                        List<Map> result =
                            await databaseHelper.readData("SELECT * FROM quiz");
                        print("$result");
                      },
                      child: Text("read "),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
