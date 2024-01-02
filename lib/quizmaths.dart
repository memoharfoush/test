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
  const Quizmath1({super.key});

  @override
  State<Quizmath1> createState() => _Quizmath1();
}

class _Quizmath1 extends State<Quizmath1> {
  @override
  //void initState() {
  // super.initState();
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  // Navigator.of(context).pop();
  //Navigator.pushNamed(context, "/homeApp");
  //});
  // }
  //final quiz = new Quiz();

  DatabaseHelper databaseHelper = DatabaseHelper();

  bool isLoading = true;
  List question = [];

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

  @override
  void initState() {
    readD();
    super.initState();
  }

  /// Database? db = await databaseHelper.initDb();
  //List<Map<String, dynamic>> maps = await db.query("quiz");

  // return List.generate(maps.length, (i) {
  // return Quiz(
  //   qId: maps[i]['quiz_id'],
  //  qname: maps[i]['name'],
  // question: maps[i]['questions']);
  //  });

//
  @override
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
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: question.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${question[i]['questext']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        int result =
                                            await databaseHelper.deletetQuiz(
                                                "DELETE FROM quiz WHERE quiz_id = ${question[i]['ques_id']}");
                                        if (result > 0) {
                                          question.removeWhere((element) =>
                                              element['ques_id'] ==
                                              question[i]['ques_id']);
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => EditQues(
                                                      queText: question[1]
                                                          ['quetext'],
                                                      quesId: question[1]
                                                          ['ques_id'],
                                                      quesMark: question[1]
                                                          ['markques'],
                                                      quiz_id: question[2]
                                                          ['quiz_id'],
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        List<Map<String, dynamic>> result =
                                            await databaseHelper
                                                .read("question");

                                        print("{$result}");
                                      },
                                      icon: Icon(
                                        Icons.read_more,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                )));
                      }),
                  Container(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.pink,
                    onPressed: () async {
                      List<Map> result = await databaseHelper.readD("question");
                      print(result);
                    },
                    child: Text("read "),
                  ),
                ],
              ),
            ),
    );
  }
}
