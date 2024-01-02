import 'package:test/databaseHelper.dart';
import 'package:test/quiz_build.dart';
import 'package:flutter/material.dart';
import 'package:test/question.dart';
import 'package:test/questionPage.dart';
import 'package:test/quizPage.dart';
import 'package:test/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/editQuiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/editQues.dart';

class Questionbuild extends StatefulWidget {
  const Questionbuild({super.key});

  @override
  State<Questionbuild> createState() => _Questionbuild();
}

class _Questionbuild extends State<Questionbuild> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = true;
  List question = [];

  final databHelper = DatabaseHelper.internal();

  readD() async {
    List<Map> result = await databaseHelper.readD("question");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('Please solve this question :'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => QuestionPag()));
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
                                        //int result =
                                        //    await databaseHelper.deletetQuiz(
                                        //        "DELETE FROM quiz WHERE ques_id = ${question[i]['ques_id']}");
                                        int result = await databaseHelper.deletetQu(
                                            "question",
                                            "ques_id=${question[i]['ques_id']}");
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
                                                      queText: question[i]
                                                          ['questext'],
                                                      quesMark: question[i]
                                                          ['markques'],
                                                      quesId: question[i]
                                                          ['ques_id'],
                                                      quiz_id: question[i]
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
                                        //  int result = await databaseHelper
                                        //      .readData("SELECT * FROM question");
                                        //  print(result);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuestionPag()));
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
