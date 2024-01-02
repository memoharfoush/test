
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


import 'databaseHelper.dart';
import 'optionbuild.dart';


class Editop extends StatefulWidget {
  final opValue;
  final correctOp;
  final opId;
  final question_id;
  const Editop(
      {super.key, this.opValue, this.correctOp, this.opId, this.question_id});

  @override
  State<Editop> createState() => _Editop();
}

class _Editop extends State<Editop> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController opValue = TextEditingController();
  TextEditingController correctOp = TextEditingController();
  TextEditingController question_id = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    opValue.text = widget.opValue;
    correctOp.text = widget.correctOp;

    super.initState();
  }

  final dbHelper = DatabaseHelper.internal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 186, 199),
        title: Text('Edit options:'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: opValue,
                      decoration: InputDecoration(hintText: "option:"),
                    ),
                    TextFormField(
                      controller: correctOp,
                      decoration: InputDecoration(hintText: "correct option:"),
                    ),
                    TextFormField(
                      controller: question_id,
                      decoration: InputDecoration(hintText: "question_id"),
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
                        int result = await databaseHelper.updateO(
                            "option",
                            {
                              "op_value": "${opValue.text}",
                              "correct_option": "${correctOp.text}",
                              "question_id": "${widget.question_id}",
                            },
                            "op_id= ${widget.opId}");
                        print("result=====");
                        print(result);
                        if (result > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Optionbuild()),
                              (route) => false);
                        }
                      },
                      child: Text("Edit option"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
