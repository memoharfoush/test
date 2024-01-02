import 'package:test/databaseHelper.dart';
import 'package:test/editOption.dart';
import 'package:test/optionpage.dart';
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

class Optionbuild extends StatefulWidget {
  const Optionbuild({super.key});

  @override
  State<Optionbuild> createState() => _Optionbuild();
}

class _Optionbuild extends State<Optionbuild> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = true;
  List option = [];

  final databHelper = DatabaseHelper.internal();

  readO() async {
    List<Map> result = await databaseHelper.read("option");
    option.addAll(result);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('choice correct option :'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OptionPag()));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: Text("Loadig..."))
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: option.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${option[i]['op_value']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        //int result =
                                        //    await databaseHelper.deletetQuiz(
                                        //        "DELETE FROM quiz WHERE ques_id = ${question[i]['ques_id']}");
                                        int result =
                                            await databaseHelper.deletetO(
                                                "option",
                                                "op_id=${option[i]['op_id']}");
                                        if (result > 0) {
                                          option.removeWhere((element) =>
                                              element['op_id'] ==
                                              option[i]['op_id']);
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Editop(
                                                    opValue: option[i]
                                                        ['op_value'],
                                                    correctOp: option[i]
                                                        ['correct_option'],
                                                    opId: option[i]['op_id'],
                                                    question_id: option[i]
                                                        ['question_id'])));
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
                                                    OptionPag()));
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
                      List<Map> result = await databaseHelper.readO("option");
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
