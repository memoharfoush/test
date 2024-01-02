import 'package:test/quiz_build.dart';
import 'package:flutter/material.dart';
import 'package:test/log_in.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/quiz.dart';

class EditQuiz extends StatefulWidget {
  final qname;
  final qId;
  const EditQuiz({super.key, this.qname, this.qId});

  @override
  State<EditQuiz> createState() => _EditQuiz();
}

class _EditQuiz extends State<EditQuiz> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController name = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    name.text = widget.qname;

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
                      controller: name,
                      decoration: InputDecoration(hintText: "Quiz name:"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () async {
                        int result = await databaseHelper.updateQuiz('''
                         UPDATE quiz SET
                         name = "${name.text}"
                         WHERE quiz_id = ${widget.qId}
                           ''');
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
