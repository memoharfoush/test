import 'package:test/Englishquiz.dart';
import 'package:test/m2.dart';
import 'package:test/question.dart';
import 'package:test/questionbuild.dart';
import 'package:test/questionPage.dart';
import 'package:test/quizPage.dart';
import 'package:test/quizmaths.dart';
import 'package:flutter/material.dart';
import 'package:test/log_in.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/quiz_build.dart';
import 'package:test/editQuiz.dart';
import 'package:test/m.dart';

class QuizBuild extends StatefulWidget {
  const QuizBuild({super.key});

  @override
  State<QuizBuild> createState() => _QuizBuild();
}

class _QuizBuild extends State<QuizBuild> {
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
  List quiz = [];

  final dbHelper = DatabaseHelper.internal();

  Future readData() async {
    List<Map> result = await databaseHelper.readData("SELECT * FROM quiz");
    quiz.addAll(result);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
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
        title: Text('Please choice your quiz :'),
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
                      itemCount: quiz.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            margin: EdgeInsets.all(15),
                            elevation: 12,
                            child: ListTile(
                                title: Text("${quiz[i]['name']}"),
                                onTap: () async {
                                  if (quiz[i]['quiz_id'] == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Quizmath()));
                                  } else if (quiz[i]['quiz_id'] == 2) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Quizeng()));
                                  }
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        int result =
                                            await databaseHelper.deletetQuiz(
                                                "DELETE FROM quiz WHERE quiz_id = ${quiz[i]['quiz_id']}");
                                        if (result > 0) {
                                          quiz.removeWhere((element) =>
                                              element['quiz_id'] ==
                                              quiz[i]['quiz_id']);
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
                                                builder: (context) => EditQuiz(
                                                      qname: quiz[i]['name'],
                                                      qId: quiz[i]['quiz_id'],
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.edit,
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
                      List<Map> result =
                          await databaseHelper.readData("SELECT * FROM quiz");
                      print(result);
                    },
                    child: Text("read "),
                  ),
                  MaterialButton(
                      onPressed: () async {
                        await databaseHelper.mydeleteDatabase();
                      },
                      child: Text('delete database')),
                ],
              ),
            ),
    );
  }
}
